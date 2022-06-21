extends Button

func _on_World_pressed():
	var stageList = get_tree().current_scene.find_node("StageList")
	var stages = PlayerData.stages_unlocked
	
	for stage in stages:
		var stage_id = stage[-1]
		var stage_panel = stageList.get_node(stage[1])
		
		stage_panel.unlockStage(self.modulate, stages[stage].name, stages[stage].best_gold)

