extends Node

const BattleUnits = preload("res://GameScenes/Battle/BattleUnits.tres")

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var postBattleContainer = $UI/PostBattleContainer
onready var topInfosContainer = $UI/TopInfosContainer
onready var enemyPosition = $EnemyPosition
onready var turnTimer = $TurnTimer

var current_stage = PlayerData.current_stage
var current_gold = 0
var current_object = 0
var last_object = 0
var dont_jump_next_object = false

var enemies = []
var player_attacking = false
var ap_gain = 1


func _ready():
	init_stage()
	

func init_stage():
	enemies = StagesData.data[current_stage].enemies
	
	player_attacking = false
	
	current_gold = 0
	current_object = 0
	last_object = enemies.size() - 1
	
	BattleUnits.Player.init()
	
	updateTopInfos()
	assignSkillsButtons()
	updateActionButtons(BattleUnits.Player.ap)
	
	create_new_object()


func create_new_object():
	var object_name = enemies[current_object]
	var object = load("res://Objects/Enemies/Scenes/%s.tscn" % object_name)
	var instance = object.instance()
	var passive = PlayerData.passive_skill
	
	enemyPosition.add_child(instance)

	if (object_name[0] != "E"):
		instance.non_enemy_setup(StagesData.data[current_stage].chest_base_gold)
		selectFirstSkill()
		passive = null
		
	elif current_object == last_object - 1:
		instance.boss_setup()
	
	player_passive_skill(passive)
	yield(get_tree().create_timer(0.5), "timeout")
	battle_turn()


func battle_turn():
	var player = BattleUnits.Player
	var enemy = BattleUnits.Enemy
	
	var battle_status = "CONTINUE"
	
	if enemy.name == "CHEST":
		player_attacking = true
		selectFirstSkill()
	elif enemy.name == "TRAP":
		player_attacking = false
	
	if player_attacking:
		yield(player.attack(enemy),"completed")
		
		if enemy.is_dead():
			battle_status = "END"
			
	else:
		player.ap += ap_gain
		
		yield(enemy.attack(player),"completed")
		
		if player.is_dead():
			battle_status = "GAMEOVER"
			enemy.queue_free()
			postBattleContainer.show_game_over()
		elif enemy.name == "TRAP":
			battle_status = "END"
			yield(enemy.die_and_free(),"completed")
	
	updateActionButtons(player.ap)
	
	if battle_status == "CONTINUE":
		player_attacking = !player_attacking
		turnTimer.start()
	elif battle_status == "END":
		current_gold += enemy.gold
		next_battle()


func _on_TurnTimer_timeout():
	battle_turn()


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
		create_new_object()
		
	elif current_object == last_object:
		yield(fade_next_screen(), "completed")
		
		create_new_object()
	else:
		postBattleContainer.show_stage_results(current_gold)


func fade_next_screen(scene = null):
	postBattleContainer.hide()
	yield(SceneTransition.transition_dissolve(scene),"completed")


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
	var next_stage = str(int(current_stage) + 1)
	
	PlayerData.stages_unlocked[current_stage].best_gold = current_gold
	
	PlayerData.stages_unlocked[next_stage] = {
		"name":StagesData.data[next_stage].name,
		"best_gold":0,
	}
	
	yield(fade_next_screen("res://GameScenes/StageSelect/StageSelect.tscn"), "completed")


func player_passive_skill(passive):
	var label = $UI/Passive
	var player = BattleUnits.Player
	
	if passive:
		label.text = "PASSIVE: " + passive
		animationPlayer.play("FadeoutPassiveLabel")
		
		match passive:
			"Attack First":
				player_attacking = true
				
			"Attack Boost":
				player.atk = PlayerData.attack_power + 1
				
			"Magic Boost":
				player.mag = PlayerData.magic_power + 1
				
			"AP Gain Boost":
				ap_gain += 1
	
	
