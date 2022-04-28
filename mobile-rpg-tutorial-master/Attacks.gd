extends Node2D

func _on_Sprite_animation_finished():
	queue_free()
	
func init(animation):
	$Sprite.play(animation)
	return self
