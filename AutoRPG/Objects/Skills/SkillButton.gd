extends Button

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")

func _on_toggled(selected):
	if (selected):
		BattleUnits.PlayerStats.active_skill = text

