extends Panel

func updatePanel():
	statText("HP", PlayerData.max_hp)
	statText("AP", PlayerData.max_ap)
	statText("ATK", PlayerData.attack_power)
	statText("MAG", PlayerData.magic_power)
	statText("WALLET", PlayerData.max_gold)
	
func statText(stat, value):
	var statLabel = get_node(stat)
	
	statLabel.text = GameData.icon[stat] + "\n" + str(value)
