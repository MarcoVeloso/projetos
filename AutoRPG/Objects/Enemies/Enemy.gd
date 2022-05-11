extends Node2D

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")

export(int) var hp = 5 setget set_hp
export(int) var damage = 4

onready var hpLabel = $HPLabel
onready var hpBar = $HPBar
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

signal died

func set_hp(new_hp):
	hp = new_hp
	if hpLabel != null:
		hpLabel.text = str(hp)
		hpBar.value = hp

func _ready():
	hpBar.max_value = hp
	set_hp(hp)
	BattleUnits.Enemy = self

func _exit_tree():
	BattleUnits.Enemy = null

func attack(player) -> void:
	sprite.play("attack")
	yield(sprite, "animation_finished")
	sprite.play("stand")

	player.hp -= damage

func take_damage(amount):
	self.hp -= amount
	
	animationPlayer.play("Shake")	
	
	if is_dead():
		sprite.play("die")
		yield(get_tree().create_timer(1.5), "timeout")
		emit_signal("died")
		queue_free()
	else:
		yield(animationPlayer, "animation_finished")

func is_dead():
	return hp <= 0
