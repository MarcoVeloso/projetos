extends Control

func changeColorPanel(color):
	var panel = $Panel
	
	panel.modulate = color
	
func unlockStage():
	var normalButton = $Normal
	var hardButton = $Hard
	
	normalButton.disabled = false
	normalButton.text = GameData.icon.PLAY

