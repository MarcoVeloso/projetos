extends Button

func _on_World_pressed():
	var stageList = get_tree().current_scene.find_node("StageList")
	var stages = PlayerData.stages_unlocked
	var world = self.name
	var world_name = StagesData.worlds[world]
	
	for stage in stageList.get_children():
		var stage_id = world + stage.name
		
		if stages.has(stage_id):
			stage.visible = true
			stage.unlockStage(
				self.modulate, 
				stage_id, 
				world_name + " " + stage.name, 
				stages[stage_id].best_gold
			)
		else:
			stage.visible = false

