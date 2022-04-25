extends Node

func battle(hero, enemy):
	
	## BATTLE PREPARATIONS ##
	update_HPBars(hero, enemy)
	hero.speed = 0
	hero.position.x = enemy.position.x - 40
	
	hero.get_node("Sprite").animation = "stand"
	enemy.get_node("Sprite").animation = "stand"
	hero.get_node("HPBar").visible = true
	enemy.get_node("HPBar").visible = true
		
	hero.get_node("Camera/Animation").play("zoom")
	hero.get_node("Camera/BattleBG/Animation").play("show")
	
	yield(hero.get_node("Camera/Animation"), "animation_finished")
	
	
	## BATTLE LOOP ##
	var hero_turn = true
	var battling = true
		
	while battling:
		if (hero_turn):
			battling = yield(attack(hero, enemy),"completed")
		else:
			battling = yield(attack(enemy, hero),"completed")
			
		hero_turn = !hero_turn
	

	## BATTLE END ##
	if (hero_turn):
		hero.queue_free()
	else:
		hero.get_node("Camera/BattleBG/Animation").play_backwards("show")
		hero.get_node("Camera/Animation").play_backwards("zoom")
		hero.get_node("HPBar").visible = false
		
		enemy.queue_free()
		hero.get_node("Sprite").animation = "walk"
		hero.speed = 100

			
func attack(attacker, attacked):
	var continue_battle = true
	
	attacker.get_node("Sprite").play("attack")
	attacked.current_hp -= attacker.attack_power
	
	yield(get_tree().create_timer(0.3),"timeout")
	update_HPBars(attacker, attacked)

	if (attacked.current_hp > 0):
		attacked.get_node("Sprite/Animation").play("hit")
	else:
		attacked.get_node("Sprite").play("lose")
		continue_battle = false
	
	yield(get_tree().create_timer(2),"timeout")

	attacker.get_node("Sprite").play("stand")
	
	return continue_battle
	

func update_HPBars(hero, enemy):
	hero.get_node("HPBar").max_value = hero.total_hp
	enemy.get_node("HPBar").max_value = enemy.total_hp
	hero.get_node("HPBar").value = hero.current_hp
	enemy.get_node("HPBar").value = enemy.current_hp



