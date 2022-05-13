extends Node

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")
const Skills = preload("res://Objects/Skills/Skills.tscn")

var hp = 999
var ap = 99

var active_skill = "SLASH"
var status = ""
var boost = ""

signal init_player()
signal hp_changed(value)
signal ap_changed(value)

func _ready():
	BattleUnits.PlayerStats = self

func _exit_tree():
	BattleUnits.PlayerStats = null
	
func attack(enemy) -> void:
	var skill_name = active_skill
	
	if enemy != null:
		var skill = Skills.instance().init(skill_name)
		var skill_data = SkillsData.data[skill_name]

		get_tree().current_scene.add_child(skill)
		skill.global_position = enemy.global_position

		ap -= skill_data["ap"]
		emit_signal("ap_changed", ap)
		
		yield(enemy.take_damage(skill_data["damage"]),"completed")
		
func take_damage(damage):
	hp -= damage
	emit_signal("hp_changed", hp)
		
func is_dead():
	return hp <= 0
	
func init():
	hp = PlayerData.max_hp
	ap = PlayerData.max_ap
	active_skill = "SLASH"
	status = ""
	boost = ""
	emit_signal("init_player")
