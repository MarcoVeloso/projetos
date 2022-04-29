extends "res://ActionButton.gd"

func _on_pressed():
	execute_skill("triple")
	
#	var enemy = BattleUnits.Enemy
#	var playerStats = BattleUnits.PlayerStats
#
#	if enemy != null and playerStats != null:
#		var slash = Attack.instance().init("triple")
#		get_tree().current_scene.add_child(slash)
#		slash.global_position = enemy.global_position
#
#		enemy.take_damage(2)
#		playerStats.mp += 2
#		playerStats.ap -= 1

	
