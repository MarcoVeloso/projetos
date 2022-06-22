extends Node

onready var worldList = $UI/WorldList

func _ready():
	loadWorlds()
	
func loadWorlds():
	var max_world = PlayerData.stages_unlocked.keys()[-1][0]
	var world = null
	
	for count in int(max_world):
		var world_num = str(count+1)
		
		world = worldList.get_node(world_num)
		world.disabled = false
		world.text = world_num
	
	loadStages(world)
	
func loadStages(world):
#	var world = worldList.get_node(max_world)
	world.pressed = true
	world.emit_signal("pressed")




