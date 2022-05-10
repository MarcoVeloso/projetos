extends Node

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")
const Skills = preload("res://Objects/Skills/Skills.tscn")

export var enemies = ["Skelton", "HalfArmorSkelton", "FullArmorSkelton", "HalfArmorSkelton", "FullArmorSkelton"]

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var enemyPosition = $EnemyPosition
onready var timeBar = $TimeBar/Animation

func _ready():
	create_new_enemy()
	
	timeBar.play("turn")
	
	var enemy = BattleUnits.Enemy
	
	if enemy != null:
		enemy.connect("died", self, "_on_Enemy_died")

func enemy_turn():
	var enemy = BattleUnits.Enemy
	
	if enemy != null and not enemy.is_queued_for_deletion():
		enemy.attack()

func player_turn():
	var player = BattleUnits.PlayerStats
	
	execute_skill(player)
	
#	playerStats.ap = playerStats.max_ap

func create_new_enemy():
	var enemySceneName = "res://Objects/Enemies/%s.tscn" % enemies.pop_front()
	var Enemy = load(enemySceneName)
	var enemy = Enemy.instance()
	
	enemyPosition.add_child(enemy)
	enemy.connect("died", self, "_on_Enemy_died")

func _on_Enemy_died():
	nextRoomButton.show()
	battleActionButtons.hide()

func _on_NextRoomButton_pressed():
	var player = BattleUnits.PlayerStats
	
	nextRoomButton.hide()
	
	animationPlayer.play("FadeToNewRoom")
	yield(animationPlayer, "animation_finished")
	
	battleActionButtons.show()
	create_new_enemy()

func execute_skill(player):
	var enemy = BattleUnits.Enemy
	var skill_name = player.active_skill
	
	if enemy != null and player != null:
		var skill = Skills.instance().init(skill_name)
		var skill_data = SkillsData.data[skill_name]

		get_tree().current_scene.add_child(skill)
		skill.global_position = enemy.global_position

		enemy.take_damage(skill_data["damage"])
		player.ap -= skill_data["ap"]

func _on_TimeBar_start_turn():
	var turn = ["player_turn", "enemy_turn"]
#	turn.invert()

	call(turn[0])
	yield(get_tree().create_timer(1.0), "timeout")
	call(turn[1])

	timeBar.play("turn")
