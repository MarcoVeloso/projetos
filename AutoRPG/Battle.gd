extends Node

const BattleUnits = preload("res://BattleUnits.tres")

export var enemies = ["Skelton", "HalfArmorSkelton", "Skelton"]

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var enemyPosition = $EnemyPosition

func _ready():
	create_new_enemy()
	start_player_turn()
	var enemy = BattleUnits.Enemy
	if enemy != null:
		enemy.connect("died", self, "_on_Enemy_died")

func start_enemy_turn():
#	battleActionButtons.hide()
	var enemy = BattleUnits.Enemy
	if enemy != null and not enemy.is_queued_for_deletion():
		enemy.attack()
		yield(enemy, "end_turn")
	start_player_turn()

func start_player_turn():
#	battleActionButtons.show()
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	yield(playerStats, "end_turn")
	start_enemy_turn()

func create_new_enemy():
	var enemySceneName = "res://Enemies/%s.tscn" % enemies.pop_front()
	var Enemy = load(enemySceneName)
	var enemy = Enemy.instance()
	enemyPosition.add_child(enemy)
	enemy.connect("died", self, "_on_Enemy_died")

func _on_Enemy_died():
	nextRoomButton.show()
	battleActionButtons.hide()

func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	animationPlayer.play("FadeToNewRoom")
	yield(animationPlayer, "animation_finished")
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	battleActionButtons.show()
	create_new_enemy()
