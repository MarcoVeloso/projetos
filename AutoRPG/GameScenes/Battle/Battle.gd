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
var current_enemy = 0
var last_enemy = 0

var enemies = []
var player_attacking = true

func _ready():
	init_stage()
	
func init_stage():
	enemies = StagesData.data[current_stage].enemies
	
	current_gold = 0
	current_enemy = 0
	last_enemy = enemies.size() - 1
	
	BattleUnits.PlayerStats.init()
	
	updateTopInfos()
	assignSkillsButtons()
	updateActionButtons(BattleUnits.PlayerStats.ap)
	
	create_new_enemy(current_enemy)
	
func create_new_enemy(enemy_index):
	var enemySceneName = ""
	
	if (enemy_index < 90):
		enemySceneName = enemies[enemy_index]
	else:
		enemySceneName = StagesData.chests_scene_name[enemy_index]
	
	var Enemy = load("res://Objects/Enemies/Scenes/%s.tscn" % enemySceneName)
	var enemy = Enemy.instance()
	
	enemyPosition.add_child(enemy)
	
	if current_enemy == last_enemy:
		enemy.boss_setup()
		
	if enemy.chest:
		enemy.chest_setup(StagesData.data[current_stage].chest_base_gold)
	
	turnTimer.start()

func _on_TurnTimer_timeout():
	var player = BattleUnits.PlayerStats
	var enemy = BattleUnits.Enemy
	
	var continue_battle = true
	
	if player_attacking:
		
		if enemy.chest:
			player.active_skill = "SLASH"
		
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
			yield(postBattleContainer.show_game_over(),"completed")
			yield(fade_next_screen(), "completed")
			init_stage()
	
	updateActionButtons(player.ap)
	
	if continue_battle:
		player_attacking = !player_attacking
		turnTimer.start()
		
func next_battle():
	if (current_enemy < 90):
		if (current_enemy == last_enemy):
			player_attacking = true
			current_enemy = 90
			updateTopInfos()
		else:
			current_enemy += 1
			updateTopInfos()
			yield(postBattleContainer.show_prepare_next_battle(),"completed")
			
		yield(fade_next_screen(), "completed")
		create_new_enemy(current_enemy)
	else:
		yield(postBattleContainer.show_stage_results(current_gold),"completed")
		yield(fade_next_screen(), "completed")
		current_stage += 1
		init_stage()

func fade_next_screen():
	animationPlayer.play("FadeToNextScreen")
	yield(animationPlayer, "animation_finished")
	
func updateActionButtons(current_ap):
	for button in battleActionButtons.get_children():
		var skill_data = SkillsData.data[button.text]
		
		if (current_ap < skill_data["ap"]):
			button.disabled = true
			
			if button.pressed:
				button.pressed = false
				battleActionButtons.get_node("0").pressed = true
		else:
			button.disabled = false
			
func assignSkillsButtons():
	var fisrt_button = battleActionButtons.get_node("0")
	var skills = PlayerData.selected_skills
	
	fisrt_button.pressed = true
	fisrt_button.emit_signal("toggled",true)
	
	for button in battleActionButtons.get_children():
		var index = int(button.name)
		
		if (skills[index]):
			button.text = skills[index]
		else:
			button.text = "SLASH"
			button.visible = false

func updateTopInfos():
	var stage = $UI/TopInfosContainer/Stage
	var gold = $UI/TopInfosContainer/Gold
	var enemies_count = $UI/TopInfosContainer/Enemies
	var topInfos = $UI/TopInfosContainer
	var enemies_left = last_enemy - current_enemy
	
	topInfos.show()
	
	stage.text = StagesData.data[current_stage].name
	gold.text = str(current_gold)
	
	if enemies_left < 0:
		topInfos.hide()
	elif enemies_left == 0:
		enemies_count.text = "BOSS"
	else:
		enemies_count.text = str(enemies_left)


