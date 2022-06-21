extends Node

onready var worldList = $UI/WorldList

func _ready():
	loadStages()
	
func loadStages():
	var max_world = PlayerData.stages_unlocked.keys()[-1][0]
	var world = worldList.get_node(max_world)

	world.emit_signal("pressed")



