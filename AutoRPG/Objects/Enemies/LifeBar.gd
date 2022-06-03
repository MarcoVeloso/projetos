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

func dead(gold_text):
	bar.hide()

	label.text = gold_text
		
	animationPlayer.play("Dead")

func setBossHPBar():
	bar.rect_scale.x = 1.5
