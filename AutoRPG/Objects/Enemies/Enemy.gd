extends Node2D

const BattleUnits = preload("res://GameScenes/Battle/BattleUnits.tres")

export(int) var hp = 999 setget set_hp
export(int) var damage = 99
export(int) var gold = 999
export(bool) var chest = false
export(String) var special = ""
export(String) var special_condition = ""

onready var lifeBar = $LifeBar
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

var max_hp = 999

func set_hp(new_hp):
	hp = new_hp
	
	if lifeBar:
		lifeBar.setHP(hp)

func _ready():
	max_hp = hp
	lifeBar.setMaxHP(max_hp)

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
		
		var dead_text = "+" + str(gold) + " gold"
		
		if chest:
			lifeBar.show()
			dead_text = "VICTORY!\n" + "+" + str(gold) + " gold"
			
		elif hp < max_hp * -0.2:
			gold = ceil(gold * 1.2)
			dead_text = "OVERKILL\n" + "+" + str(gold) + " gold"
				
		lifeBar.dead(dead_text)
			
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
	damage = ceil(damage * 1.5)
	gold *= 2
	lifeBar.setMaxHP(hp)
	
func chest_setup(chest_base_gold):
	gold = chest_base_gold * gold 
	lifeBar.hide()
