extends Node

const BattleUnits = preload("res://GameParts/Battle/BattleUnits.tres")

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var postBattleContainer = $UI/PostBattleContainer
onready var enemyPosition = $EnemyPosition
onready var turnTimer = $TurnTimer

var current_stage = 0
var enemies = []
var player_attacking = true

func _ready():
	init_stage(StagesData.data[current_stage])
	
func init_stage(stage):
	enemies = stage.duplicate()
	
	BattleUnits.PlayerStats.init()
	
	assignSkillsButtons()
	updateActionButtons(BattleUnits.PlayerStats.ap)
	
	create_new_enemy()
	
func create_new_enemy():
	var enemySceneName = "res://Objects/Enemies/%s.tscn" % enemies.pop_front()
	var Enemy = load(enemySceneName)
	var enemy = Enemy.instance()
	
	enemyPosition.add_child(enemy)
	
	if (enemies.size() == 0):
		enemy.boss_setup()
	
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
	
	if (enemies.size() == 0):
		current_stage += 1
		init_stage(StagesData.data[current_stage])
	else:
		create_new_enemy()
	
func game_over():
	postBattleContainer.show()
	var restart = postBattleContainer.get_node("RestartButton")
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
	var skills = PlayerData.selected_skills
	
	battleActionButtons.get_node("0").pressed = true
	battleActionButtons.get_node("0").emit_signal("toggled",true)
	
	for button in battleActionButtons.get_children():
		var index = int(button.name)
		
		if (skills[index]):
			button.text = skills[index]
		else:
			button.text = "SLASH"
			button.visible = false
			

		
		
		

