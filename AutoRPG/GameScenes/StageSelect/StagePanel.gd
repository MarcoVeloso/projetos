extends Control

var global_stage_id = GameData.current_stage
	
func unlockStage(color, stage_id, stage_name, best_gold):
	var panel = $Panel
	var label_name = $Name
	var label_best = $Best
	
	panel.modulate = color
	global_stage_id = stage_id
	
	label_name.text = stage_name
	self.visible = true
	
	if best_gold:
		var hardButton = $Hard

		label_best.text = "Best $: " + best_gold
		hardButton.disabled = false
		hardButton.text = GameData.icon.SKULL

func _on_Normal_pressed():
	GameData.current_stage = global_stage_id
	SceneTransition.transition_dissolve("res://GameScenes/Battle/Battle.tscn")
	
func _on_Hard_pressed():
	GameData.current_stage = global_stage_id + "H"
	SceneTransition.transition_dissolve("res://GameScenes/Battle/Battle.tscn")
