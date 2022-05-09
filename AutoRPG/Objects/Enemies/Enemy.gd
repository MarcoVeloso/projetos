extends Node2D

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")

export(int) var hp = 5 setget set_hp
export(int) var damage = 4

onready var hpLabel = $HPLabel
onready var hpBar = $HPBar
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var playerSprite = get_node("/root/Battle/UI/PlayerPanel/Sprite")

signal died
signal end_turn

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

func attack() -> void:
	sprite.play("attack")
	yield(sprite, "animation_finished")
	sprite.play("stand")

	deal_damage(damage)	
	
	playerSprite.play("hurt")	
	yield(playerSprite, "animation_finished")
	playerSprite.play("stand")
		
	emit_signal("end_turn")

func deal_damage(amount):
	BattleUnits.PlayerStats.hp -= amount

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
