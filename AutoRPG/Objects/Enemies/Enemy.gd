extends Node2D

const BattleUnits = preload("res://GameParts/Battle/BattleUnits.tres")

export(int) var hp = 999 setget set_hp
export(int) var damage = 99
export(int) var gold = 999
export(String) var special = ""
export(String) var special_condition = ""

onready var lifeBar = $LifeBar
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

func set_hp(new_hp):
	hp = new_hp
	
	if lifeBar:
		lifeBar.setHP(hp)

func _ready():
	lifeBar.setMaxHP(hp)

	BattleUnits.Enemy = self

func _exit_tree():
	BattleUnits.Enemy = null

func attack(player) -> void:
	sprite.play("attack")
	yield(sprite, "animation_finished")
	sprite.play("stand")

	player.take_damage(damage)

func take_damage(damage):
	self.hp -= damage
	
	animationPlayer.play("Shake")
	yield(animationPlayer, "animation_finished")
	animationPlayer.play("Stand")
	
	if is_dead():
		sprite.material = null
		lifeBar.dead()
			
		sprite.play("die")
		yield(sprite, "animation_finished")
		
		animationPlayer.play("Fadeout")
		yield(animationPlayer, "animation_finished")
		
		queue_free()

func is_dead():
	return hp <= 0
	
func boss_setup():
	self.scale = Vector2(0.85, 0.85)
	sprite.material = ShaderMaterial.new()
	sprite.material.shader = load("res://UI/OutlineAura.tres")
	
	hp *= 2
	damage *= round(1.5)
	gold *= 3
	lifeBar.setMaxHP(hp)
