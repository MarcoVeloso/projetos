extends Button

func _on_World_pressed():
	var stageList = get_tree().current_scene.find_node("StageList")

	for stage in stageList.get_children():
		var id_stage = int(self.name + stage.name)
		
		if id_stage < PlayerData.max_unlocked_stage:
			stage.unlockStage(true)
		elif id_stage == PlayerData.max_unlocked_stage:
			stage.unlockStage(false)
		
		stage.changeColorPanel(self.modulate)

