extends Node2D

const BattleUnits = preload("res://GameScenes/Battle/BattleUnits.tres")

export(int) var hp = 999 setget set_hp
export(int) var damage = 99
export(int) var gold = 999

export(String) var special = ""
export(String) var special_condition = ""

onready var lifeBar = $LifeBar
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

var HP = 999

func set_hp(new_hp):
	hp = new_hp
	
	if lifeBar:
		lifeBar.setHP(hp)

func _ready():
	HP = hp
	lifeBar.setMaxHP(HP)

	BattleUnits.Enemy = self

func _exit_tree():
	BattleUnits.Enemy = null

func attack(player) -> void:
	if self.name == "OVERSIZE":
		sprite.offset.y = 12
		
	sprite.play("attack")
	yield(sprite, "animation_finished")
	sprite.offset.y = 0
	sprite.play("stand")

	player.take_damage(damage)

func take_damage(damage):
	self.hp -= damage
	
	animationPlayer.play("Shake")
	yield(animationPlayer, "animation_finished")
	animationPlayer.play("Stand")
	
	if is_dead():
		yield(die_and_free(),"completed")

func is_dead():
	return hp <= 0
	
func die_and_free():
	sprite.material = null
	
	var dead_text = "+" + str(gold) + " $"
	
	if self.name == "CHEST":
		dead_text = "Treasure!\n+" + str(gold) + " $"
	elif self.name == "TRAP":
		dead_text = "Trap!\n" + str(gold) + " $"
	elif hp < HP * -0.2:
		gold = ceil(gold * 1.2)
		dead_text = "OVERKILL Bonus!\n+" + str(gold) + " $"
			
	lifeBar.dead(dead_text)
		
	sprite.play("die")
	yield(sprite, "animation_finished")
	
	animationPlayer.play("Fadeout")
	yield(animationPlayer, "animation_finished")
	
	queue_free()
	
func boss_setup():
	lifeBar.setBossHPBar()
	sprite.material = ShaderMaterial.new()
	sprite.material.shader = load("res://UI/OutlineAura.tres")
	
	hp = floor(hp * 1.5)
	damage = floor(damage * 1.5)
	gold = ceil(gold * 2)
	
	lifeBar.setMaxHP(hp)
	
func non_enemy_setup(chest_base_gold):
	hp = 0
	
	if self.name == "CHEST": 
		gold = chest_base_gold * gold
		
	lifeBar.hide()
	
func hardmode_setup():
	hp = floor(hp * 2.5)
	damage = floor(damage * 2.5)
	gold = ceil(gold * 2.5)
	
	lifeBar.setMaxHP(hp)
