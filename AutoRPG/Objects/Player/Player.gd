extends Node

const BattleUnits = preload("res://GameScenes/Battle/BattleUnits.tres")
const Skills = preload("res://Objects/Skills/Skills.tscn")

var hp = 999 setget set_hp
var ap = 99 setget set_ap
var atk = 99
var mag = 99

var active_skill = "SLASH"
var damage_mod = 0

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
	ap = PlayerData.start_ap
	atk = PlayerData.attack_power
	mag = PlayerData.magic_power
	active_skill = "SLASH"

	emit_signal("init_player")
