extends Node

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")

export var stage1 = ["SkeltonMACE", "SkeltonAXE", "SkeltonBOW", "SkeltonSPEAR", "SkeltonSPEAR"]

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var postBattleContainer = $UI/PostBattleContainer
onready var enemyPosition = $EnemyPosition
onready var turnTimer = $TurnTimer

var enemies = []
var player_attacking = true

func _ready():
	init_stage(stage1)
	
func init_stage(stage):
	enemies = stage.duplicate()
	
	BattleUnits.PlayerStats.init()
	
	updateActionButtons(BattleUnits.PlayerStats.ap)
	create_new_enemy()
	
func create_new_enemy():
	var enemySceneName = "res://Objects/Enemies/%s.tscn" % enemies.pop_front()
	var Enemy = load(enemySceneName)
	var enemy = Enemy.instance()
	
	enemyPosition.add_child(enemy)
	
	turnTimer.start()

func _on_RestartButton_pressed():
	postBattleContainer.hide()
	yield(battleFade(), "completed")
	init_stage(stage1)

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
				battleActionButtons.get_node("Button1").pressed = true
		else:
			button.disabled = false
