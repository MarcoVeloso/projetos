extends Line2D

signal start_turn

func _on_Animation_animation_finished(anim_name):
	if (anim_name == "turn"):
		emit_signal("start_turn")
