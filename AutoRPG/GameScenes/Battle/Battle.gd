extends Node

const BattleUnits = preload("res://GameScenes/Battle/BattleUnits.tres")

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var postBattleContainer = $UI/PostBattleContainer
onready var topInfosContainer = $UI/TopInfosContainer
onready var enemyPosition = $EnemyPosition
onready var turnTimer = $TurnTimer

var current_stage = 0
var current_gold = 0
var current_object = 0
var last_object = 0
var dont_jump_next_object = false

var enemies = []
var player_attacking = true


func _ready():
	init_stage()
	

func init_stage():
	enemies = StagesData.data[current_stage].enemies
	
	player_attacking = true
	
	current_gold = 0
	current_object = 0
	last_object = enemies.size() - 1
	
	BattleUnits.Player.init()
	
	updateTopInfos()
	assignSkillsButtons()
	updateActionButtons(BattleUnits.Player.ap)
	
	create_new_object(enemies[current_object])


func _on_TurnTimer_timeout():
	battle_turn()
	
	
func battle_turn():
	var player = BattleUnits.Player
	var enemy = BattleUnits.Enemy
	
	var continue_battle = true
	
	if enemy.name == "CHEST":
		player_attacking = true
		selectFirstSkill()
	elif enemy.name == "TRAP":
		player_attacking = false
	
	if player_attacking:
		yield(player.attack(enemy),"completed")
		
		if enemy.is_dead():
			current_gold += enemy.gold
			continue_battle = false
			next_battle()
	else:
		player.ap += 1
		
		yield(enemy.attack(player),"completed")
		
		if player.is_dead():
			continue_battle = false
			enemy.queue_free()
			postBattleContainer.show_game_over()
		elif enemy.name == "TRAP":
			continue_battle = false
			yield(enemy.die_and_free(),"completed")
			next_battle()
	
	updateActionButtons(player.ap)
	
	if continue_battle:
		player_attacking = !player_attacking
		turnTimer.start()


func next_battle():
	dont_jump_next_object = false
	current_object += 1
	
	updateTopInfos()
	
	if current_object < last_object:
		var show_secret_button = false
		
		if enemies[current_object][0] != "E":
			show_secret_button = true
			current_object += 1
		
		yield(postBattleContainer.show_prepare_next_battle(show_secret_button),"completed")
		yield(fade_next_screen(), "completed")
		
		if dont_jump_next_object:
			current_object -= 1
			
		updateTopInfos()
		create_new_object(enemies[current_object])
		
	elif current_object == last_object:
		yield(fade_next_screen(), "completed")
		
		create_new_object(enemies[current_object])
	else:
		postBattleContainer.show_stage_results(current_gold)


func fade_next_screen():
	postBattleContainer.hide()
	animationPlayer.play("FadeToNextScreen")
	yield(animationPlayer, "animation_finished")


func updateActionButtons(current_ap):
	for button in battleActionButtons.get_children():
		
		if button.text != GameData.icon.LOCK:
			var skill_data = SkillsData.data[button.text]
			
			if (current_ap < skill_data["ap"]):
				button.disabled = true
				
				if button.pressed:
					button.pressed = false
					selectFirstSkill()
			else:
				button.disabled = false
		else:
			button.disabled = true


func assignSkillsButtons():
	var skills = PlayerData.selected_skills
	
	selectFirstSkill()
	
	for button in battleActionButtons.get_children():
		var index = int(button.name)
		
		if (skills[index]):
			button.text = skills[index]
		else:
			button.text = GameData.icon.LOCK


func updateTopInfos():
	var stage = $UI/TopInfosContainer/Stage
	var gold = $UI/TopInfosContainer/Gold
	var room = $UI/TopInfosContainer/Room
	var object_count = (last_object - current_object) - 1
	
	stage.text = StagesData.data[current_stage].name
	gold.text = GameData.icon.GOLD + ' ' + str(current_gold)
	
	if object_count > 0:
		room.text = GameData.icon.FINAL + ' ' + str(object_count)
	elif object_count == 0:
		room.text = "BOSS"
	else:
		room.text = "FINAL"


func create_new_object(object_name):
	var object = load("res://Objects/Enemies/Scenes/%s.tscn" % object_name)
	var instance = object.instance()
	
	enemyPosition.add_child(instance)

	if (object_name[0] != "E"):
		instance.non_enemy_setup(StagesData.data[current_stage].chest_base_gold)
		selectFirstSkill()
		
	elif current_object == last_object - 1:
		instance.boss_setup()
	
	yield(get_tree().create_timer(0.5), "timeout")
	battle_turn()
	
	
func selectFirstSkill():
	var fisrt_button = battleActionButtons.get_node("0")
	fisrt_button.pressed = true
	fisrt_button.emit_signal("toggled",true)
	
	
func _on_SecretButton_toggled(selected):
	if selected:
		dont_jump_next_object = true
	else:
		dont_jump_next_object = false


func _on_RestartButton_pressed():
	yield(fade_next_screen(), "completed")
	init_stage()


func _on_NextStageButton_pressed():
	current_stage += 1
	yield(fade_next_screen(), "completed")
	init_stage()
