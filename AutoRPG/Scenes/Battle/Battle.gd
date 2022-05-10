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

func start_enemy_turn():
	var enemy = BattleUnits.Enemy
	
	if enemy != null and not enemy.is_queued_for_deletion():
		enemy.attack()
		yield(get_tree().create_timer(1.0), "timeout")
		
	start_player_turn()

func start_player_turn():
	var playerStats = BattleUnits.PlayerStats
	
	yield(get_tree().create_timer(0.3), "timeout")
	execute_skill(BattleUnits.PlayerStats.active_skill)
	
	playerStats.ap = playerStats.max_ap
	
	timeBar.play("turn")

#	start_enemy_turn()

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
	var playerStats = BattleUnits.PlayerStats
	
	nextRoomButton.hide()
	
	animationPlayer.play("FadeToNewRoom")
	yield(animationPlayer, "animation_finished")
	
	playerStats.ap = playerStats.max_ap
	battleActionButtons.show()
	create_new_enemy()

func execute_skill(skill_name):
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	
	if enemy != null and playerStats != null:
		var skill = Skills.instance().init(skill_name)
		var skill_data = SkillsData.data[skill_name]

		get_tree().current_scene.add_child(skill)
		skill.global_position = enemy.global_position

		enemy.take_damage(skill_data["damage"])
		playerStats.ap -= skill_data["ap"]

func _on_TimeBar_start_turn():
	start_enemy_turn()
