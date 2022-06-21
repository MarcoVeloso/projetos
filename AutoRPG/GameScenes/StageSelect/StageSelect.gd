extends Node

onready var worldList = $UI/WorldList

func _ready():
	var max_world = str(PlayerData.max_unlocked_stage)[0]
	var world = worldList.get_node(max_world)

	world.emit_signal("pressed")



