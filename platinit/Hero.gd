extends KinematicBody2D

const gravity = 800

export var total_hp = 10
export var current_hp = 10
export var ATK = 2

export var speed = 100
export var jumpForce = 500

var vel = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vel.x = speed
	vel.y += gravity * delta

	# jump inputs
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y -= jumpForce
	
	# applying the velocity
	vel = move_and_slide(vel, Vector2.UP)

