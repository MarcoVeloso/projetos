extends Button

func _on_World_pressed():
	var stageList = get_tree().current_scene.find_node("StageList")

	for stage in stageList.get_children():
		stage.changeColorPanel(self.modulate)

