extends Node2D

func _on_Sprite_animation_finished():
	queue_free()

func _on_Slash_ready():
	$Sprite.play("slash")
