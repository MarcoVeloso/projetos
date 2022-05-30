extends Node

const BattleUnits = preload("res://GameScenes/Battle/BattleUnits.tres")
const Skills = preload("res://Objects/Skills/Skills.tscn")

var hp = 999 setget set_hp
var ap = 99 setget set_ap

var active_skill = "SLASH"
var status = ""
var boost = ""

signal init_player()
signal hp_changed(value)
signal ap_changed(value)
signal update_player_face(type)

func set_hp(new_hp):
	hp = clamp(new_hp, 0, PlayerData.max_hp)
	emit_signal("hp_changed", hp)
	
func set_ap(new_ap):
	ap = clamp(new_ap, 0, PlayerData.max_ap)
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
		
		var player_position = Vector2(16,71.5)
		
		set_ap(ap - skill_data["ap"])

		get_tree().current_scene.add_child(skill)
		
		match skill_data["type"]:
			"damage":
				skill.global_position = enemy.global_position
				yield(enemy.take_damage(skill_data["effect"]),"completed")
			"heal":
				skill.global_position = player_position
				set_hp(hp + skill_data["effect"]) 
				emit_signal("update_player_face", "heal")
				yield(get_tree().create_timer(0.5), "timeout")
			"shield":
				skill.global_position = player_position
				emit_signal("update_player_face", "defend")
				yield(get_tree().create_timer(0.5), "timeout")
					
func take_damage(damage):
	set_hp(hp - damage)
	
	if hp <= (PlayerData.max_hp * 0.5):
		emit_signal("update_player_face", "weak")
	else:
		emit_signal("update_player_face", "damage")
		
func is_dead():
	if hp <= 0:
		emit_signal("update_player_face", "die")
		return true
	else:
		return false
	
func init():
	hp = PlayerData.max_hp
	ap = PlayerData.max_ap
	active_skill = "SLASH"
	status = ""
	boost = ""
	emit_signal("init_player")
