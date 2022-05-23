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
var enemies_left = 0

var enemies = []
var player_attacking = true

func _ready():
	init_stage(StagesData.data[current_stage])
	
func init_stage(stage):
	enemies = stage.duplicate()
	current_gold = 0
	
	BattleUnits.PlayerStats.init()
	
	assignSkillsButtons()
	updateActionButtons(BattleUnits.PlayerStats.ap)
	
	create_new_enemy()
	
func create_new_enemy():
	var enemySceneName = "res://Objects/Enemies/%s.tscn" % enemies.pop_front()
	var Enemy = load(enemySceneName)
	var enemy = Enemy.instance()
	
	enemyPosition.add_child(enemy)
	
	enemies_left = enemies.size()
	
	if (enemies_left == 0):
		enemy.boss_setup()
	
	updateTopInfos()
	
	turnTimer.start()

func _on_RestartButton_pressed():
	postBattleContainer.hide()
	yield(battleFade(), "completed")
	init_stage(StagesData.data[current_stage])

func _on_TurnTimer_timeout():
	var player = BattleUnits.PlayerStats
	var enemy = BattleUnits.Enemy
	
	var continue_battle = true
	
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
			game_over()
	
	updateActionButtons(player.ap)
	
	if continue_battle:
		player_attacking = !player_attacking
		turnTimer.start()
		
func next_battle():
	yield(battleFade(), "completed")
	
	if (enemies_left == 0):
		current_stage += 1
		init_stage(StagesData.data[current_stage])
	else:
		create_new_enemy()
	
func game_over():
	postBattleContainer.show()
	var restart = $UI/PostBattleContainer/RestartButton
	yield(restart, "pressed")

func battleFade():
	animationPlayer.play("FadeToNewRoom")
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
	
	stage.text = "Stage " + str(current_stage)
	gold.text = str(current_gold)
	enemies_count.text = str(enemies_left)
			

		
		
		

