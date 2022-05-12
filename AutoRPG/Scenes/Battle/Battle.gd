extends Node

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")

export var enemies = ["SkeltonMACE", "SkeltonAXE", "SkeltonBOW", "SkeltonSPEAR", "SkeltonSPEAR"]

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var enemyPosition = $EnemyPosition
onready var turnTimer = $TurnTimer

var player_attacking = true

func _ready():
	create_new_enemy()

func create_new_enemy():
	var enemySceneName = "res://Objects/Enemies/%s.tscn" % enemies.pop_front()
	var Enemy = load(enemySceneName)
	var enemy = Enemy.instance()
	
	enemyPosition.add_child(enemy)
	
	turnTimer.start()

func _on_NextRoomButton_pressed():
	var player = BattleUnits.PlayerStats
	
	nextRoomButton.hide()
	
	animationPlayer.play("FadeToNewRoom")
	yield(animationPlayer, "animation_finished")
	
	battleActionButtons.show()
	create_new_enemy()

func _on_TurnTimer_timeout():
	var player = BattleUnits.PlayerStats
	var enemy = BattleUnits.Enemy
	
	var attacker = enemy
	var attacked = player
	
	if player_attacking:
		attacker = player
		attacked = enemy
		
	attacker.attack(attacked)
	
	if attacked.is_dead():
		nextRoomButton.show()
		battleActionButtons.hide()
	else:
		player_attacking = !player_attacking
		turnTimer.start()
