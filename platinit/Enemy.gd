extends Area2D

export var total_hp = 8
export var current_hp = 8
export var ATK = 2

#func _ready():
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Enemy_body_entered(body):	
	if (body.name == "Hero"):
		Battle.battle(body, self)
