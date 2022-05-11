extends Node

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")
const Skills = preload("res://Objects/Skills/Skills.tscn")

var max_hp = PlayerData.max_hp
var hp = max_hp setget set_hp
var max_ap = PlayerData.max_ap
var ap = max_ap setget set_ap

var active_skill = "SLASH"

signal hp_changed(value)
signal ap_changed(value)

func set_hp(value):
	hp = clamp(value, 0, max_hp)
	emit_signal("hp_changed", hp)

func set_ap(value):
	ap = clamp(value, 0, max_ap)
	emit_signal("ap_changed", ap)

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
		yield(enemy.take_damage(skill_data["damage"]),"completed")
		
func is_dead():
	return hp <= 0
