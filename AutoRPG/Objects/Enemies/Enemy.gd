extends Node2D

const BattleUnits = preload("res://Scenes/Battle/BattleUnits.tres")

export(int) var hp = 99 setget set_hp
export(int) var damage = 99
export(String) var attack_anim = "attack"

onready var hpLabel = $HPLabel
onready var hpBar = $HPBar
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

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
	sprite.play(attack_anim)
	yield(sprite, "animation_finished")
	sprite.play("stand")

	player.hp -= damage

func take_damage(amount):
	self.hp -= amount
	
	animationPlayer.play("Shake")
	yield(animationPlayer, "animation_finished")
	animationPlayer.play("Stand")
	
	if is_dead():
		sprite.play("die")
		yield(sprite, "animation_finished")
		animationPlayer.play("Fadeout")
		yield(animationPlayer, "animation_finished")
		
		queue_free()

func is_dead():
	return hp <= 0
