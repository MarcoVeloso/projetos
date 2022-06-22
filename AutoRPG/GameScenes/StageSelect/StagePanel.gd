extends Control

var global_stage_id = "11"
	
func unlockStage(color, stage_id, stage_name, best_gold):
	var panel = $Panel
	var label_name = $Name
	var label_best = $Best
	
	panel.modulate = color
	global_stage_id = stage_id
	
	label_name.text = stage_name
	label_best.text = "Best $: " + str(best_gold)
	self.visible = true
	
	if best_gold > 0:
		var hardButton = $Hard

		hardButton.disabled = false
		hardButton.text = GameData.icon.SKULL

func _on_Normal_pressed():
	PlayerData.current_stage = global_stage_id
	SceneTransition.transition_dissolve("res://GameScenes/Battle/Battle.tscn")
	
func _on_Hard_pressed():
	print('H' + global_stage_id)
