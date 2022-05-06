extends Node

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")
const Skills = preload("res://Objects/Skills/Skills.tscn")

export var enemies = ["Skelton", "HalfArmorSkelton", "FullArmorSkelton"]

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var enemyPosition = $EnemyPosition

func _ready():
	create_new_enemy()
	
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
	yield(get_tree().create_timer(2), "timeout")
	var playerStats = BattleUnits.PlayerStats
	
	execute_skill(BattleUnits.PlayerStats.active_skill)
	
	playerStats.ap = playerStats.max_ap
#	yield(playerStats, "end_turn")
	start_enemy_turn()

func create_new_enemy():
	var enemySceneName = "res://Objects/Enemies/%s.tscn" % enemies.pop_front()
	var Enemy = load(enemySceneName)
	var enemy = Enemy.instance()
	enemyPosition.add_child(enemy)
	enemy.connect("died", self, "_on_Enemy_died")
	start_player_turn()

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

var skills_data = {
	"SLASH": {
		"damage":1,
		"ap":0,
		"description":"Slash - 0AP\nBasic slash attack"
	},
	"CROSS": {
		"damage":2,
		"ap":3,
		"description":"Cross Slash - 3AP\nCross slash attack"
	},
	"TRIPLE": {
		"damage":3,
		"ap":5,
		"description":"Triple Slash - 5AP\nTriple slash attack"
	},
	"COMBO": {
		"damage":10,
		"ap":10,
		"description":"Combo Slash - 10AP\nPowerful combo! Hits very very hard!"
	},
	
}

func execute_skill(skill_name):
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	var textbox = get_tree().current_scene.find_node("Textbox")		
	
	if enemy != null and playerStats != null:
		var skill = Skills.instance().init(skill_name)
		var skill_data = skills_data[skill_name]
		
		get_tree().current_scene.add_child(skill)
		skill.global_position = enemy.global_position
		
		enemy.take_damage(skill_data["damage"])
		playerStats.ap -= skill_data["ap"]
		
		textbox.text = skill_data["description"]
