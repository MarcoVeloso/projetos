extends Node

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")

var max_hp = 10
var hp = max_hp setget set_hp
var max_ap = 3
var ap = max_ap setget set_ap

signal hp_changed(value)
signal ap_changed(value)
signal end_turn

func set_hp(value):
	hp = clamp(value, 0, max_hp)
	emit_signal("hp_changed", hp)

func set_ap(value):
	ap = clamp(value, 0, max_ap)
	emit_signal("ap_changed", ap)
#	if ap == 0:
#		emit_signal("end_turn")

func _ready():
	BattleUnits.PlayerStats = self

func _exit_tree():
	BattleUnits.PlayerStats = null
