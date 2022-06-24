extends CanvasLayer

func transition_dissolve(target = null):
	$AnimationPlayer.play('dissolve')
	yield($AnimationPlayer,'animation_finished')
	if target:
		get_tree().change_scene(target)
	$AnimationPlayer.play_backwards('dissolve')
