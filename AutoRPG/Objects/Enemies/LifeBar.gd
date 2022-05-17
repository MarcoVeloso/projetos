extends Node2D

onready var label = $Label
onready var bar = $Bar
onready var animationPlayer = $AnimationPlayer

func setMaxHP(hp):
	bar.max_value = hp
	setHP(hp)
	
func setHP(hp):
	label.text = str(hp)
	bar.value = hp

func dead():
	bar.hide()

	if int(label.text) < bar.max_value * -0.2:
		label.text = "OVERKILL"
	else:
		label.text = "Defeated"
		
	animationPlayer.play("Dead")
