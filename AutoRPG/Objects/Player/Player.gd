extends Node

const BattleUnits = preload("res://GameScenes/Battle/BattleUnits.tres")
const Skills = preload("res://Objects/Skills/Skills.tscn")

var hp = 999 setget set_hp
var ap = 99 setget set_ap
var atk = 99 setget set_atk
var mag = 99 setget set_mag

var active_skill = "SLASH"
var damage_mod = 0

signal stat_changed(stat, value)
signal update_player_face(type)

func set_hp(new_hp):
	hp = clamp(new_hp, 0, PlayerData.HP)
	emit_signal("stat_changed", "hp", hp)
	
func set_ap(new_ap):
	ap = clamp(new_ap, 0, PlayerData.AP)
	emit_signal("stat_changed", "ap", ap)
	
func set_atk(new_atk):
	atk = clamp(new_atk, 0, new_atk)
	emit_signal("stat_changed", "atk", atk)
	
func set_mag(new_mag):
	mag = clamp(new_mag, 0, new_mag)
	emit_signal("stat_changed", "mag", mag)
	
func _ready():
	BattleUnits.Player = self

func _exit_tree():
	BattleUnits.Player = null
	
func attack(enemy) -> void:
	var skill_name = active_skill
	
	if enemy != null:
		var skill = Skills.instance().init(skill_name)
		var skill_data = SkillsData.data[skill_name]
		
		var player_position = Vector2(16,71.5)
		
		set_ap(ap - skill_data["ap"])

		get_tree().current_scene.add_child(skill)
		
		match skill_data["target"]:
			"other":
				var damage = skill_data["effect"] * atk
				
				match skill_data["type"]:
					"magic":
						damage = skill_data["effect"] * mag
					"APgain":
						damage = skill_data["effect"]
						set_ap(ap + 1)
					
				skill.global_position = enemy.global_position
				yield(enemy.take_damage(damage),"completed")
				
				if enemy.name == "CHEST":
					emit_signal("update_player_face", "stayhappy")
				
			"self":
				var player_face = ""
				
				match skill_data["type"]:
					"heal":
						player_face = "happy"
						set_hp(hp + skill_data["effect"])
					"shield":
						player_face = "shield"
						damage_mod = -skill_data["effect"]
				
				skill.global_position = player_position
				emit_signal("update_player_face", player_face)
				yield(get_tree().create_timer(0.2), "timeout")
				
					
func take_damage(damage):
	var final_damage = damage + damage_mod
	
	set_hp(hp - clamp(final_damage, 0, final_damage))
	
	damage_mod = 0
	
	if hp <= (PlayerData.HP * 0.5):
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
	set_hp(PlayerData.HP)
	set_ap(PlayerData.AP)
	set_atk(PlayerData.ATK)
	set_mag(PlayerData.MAG)
	
	active_skill = "SLASH"

	emit_signal("update_player_face", "normal")
