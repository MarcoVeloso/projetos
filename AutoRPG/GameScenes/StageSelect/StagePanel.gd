extends Control

func changeColorPanel(color):
	var panel = $Panel
	
	panel.modulate = color
	
func unlockStage(played):
	self.visible = true
	
	if played:
		var hardButton = $Hard
		
		hardButton.disabled = false
		hardButton.text = GameData.icon.SKULL

