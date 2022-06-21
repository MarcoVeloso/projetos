extends Control
	
func unlockStage(color, stage_name, best_gold):
	var panel = $Panel
	var label_name = $Name
	var label_best = $Best
	
	panel.modulate = color
	
	label_name.text = stage_name
	label_best.text = "Best $: " + str(best_gold)
	self.visible = true
	
	if best_gold > 0:
		var hardButton = $Hard

		hardButton.disabled = false
		hardButton.text = GameData.icon.SKULL

