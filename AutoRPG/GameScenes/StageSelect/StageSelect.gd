extends Node

onready var stageList = $UI/StageList

func _ready():
	updateStageList()


func updateStageList():
	for stage in stageList.get_children():
		print(stage)
