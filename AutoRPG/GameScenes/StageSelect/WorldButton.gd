extends Button

func _on_World_pressed():
	var stageList = get_tree().current_scene.find_node("StageList")
	var stages = PlayerData.stages_unlocked
	
	for stage in stageList.get_children():
		var stage_id = self.name + stage.name
		
		if stages.has(stage_id):
			stage.visible = true
			stage.unlockStage(self.modulate, stages[stage_id].name, stages[stage_id].best_gold)
		else:
			stage.visible = false

