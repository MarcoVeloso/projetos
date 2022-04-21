extends Area2D

export var total_hp = 8
export var current_hp = 8
export var attack_power = 2

onready var hero = get_node("/root/Game/Hero")

#func _ready():
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Enemy_body_entered(body):	
	if (body.name == "Hero"):
		battle_start()


func battle_start():
	update_HPBars()	
	hero.speed = 0
	hero.position.x = self.position.x - 40
	
	hero.get_node("Sprite").animation = "stand"
	self.get_node("Sprite").animation = "stand"
	hero.get_node("HPBar").visible = true
	self.get_node("HPBar").visible = true
		
	hero.get_node("Camera/Animation").play("zoom")
	hero.get_node("Camera/BattleBG/Animation").play("show")
	
	yield(hero.get_node("Camera/Animation"), "animation_finished")
	
	battle_loop()
	

func battle_loop():
	var hero_attacking = false
	var battling = true
		
	while battling:
		hero_attacking = !hero_attacking
		
		if (hero_attacking):
			battling = yield(attack(hero, self),"completed")
		else:
			battling = yield(attack(self, hero),"completed")
								
		
	battle_end()

			
func attack(attacker, attacked):
	var continue_battle = true
	
	attacker.get_node("Sprite").play("attack")
	attacked.current_hp -= attacker.attack_power
	
	yield(get_tree().create_timer(0.3),"timeout")
	update_HPBars()

	if (attacked.current_hp > 0):
		attacked.get_node("Sprite/Animation").play("hit")
	else:
		attacked.get_node("Sprite").play("lose")
		continue_battle = false
	
	yield(get_tree().create_timer(2),"timeout")

	attacker.get_node("Sprite").play("stand")
	
	return continue_battle
	

func update_HPBars():
	hero.get_node("HPBar").max_value = hero.total_hp
	self.get_node("HPBar").max_value = self.total_hp
	hero.get_node("HPBar").value = hero.current_hp
	self.get_node("HPBar").value = self.current_hp


func battle_end():
	hero.get_node("Camera/BattleBG/Animation").play_backwards("show")
	hero.get_node("Camera/Animation").play_backwards("zoom")
	hero.get_node("HPBar").visible = false
	
	self.queue_free()
	hero.get_node("Sprite").animation = "walk"
	hero.speed = 100
	
	
	
