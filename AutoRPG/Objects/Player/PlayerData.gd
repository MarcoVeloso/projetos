extends Node

var max_hp = 10
var max_ap = 100
var start_ap = 100
var max_gold = 100
var attack_power = 1
var magic_power = 1

var gold = 6578 setget set_gold
var current_stage = "11"

var stages_unlocked = {
	"11":{"name":StagesData.data["11"].name,"best_gold":""},
}

var passive_skill = "Attack First"
#var passive_skill = "Attack Boost"
#var passive_skill = "Magic Boost"
#var passive_skill = "AP Gain Boost"

var selected_skills = ["SLASH", "HEAL", "DEFEND", "SWIFT", "CROSS", "CRESCENT", "EXPLOSION", "ULTIMA"]
#var selected_skills = ["SLASH", "HEAL", null, null, null, null, null, null]


func set_gold(new_gold):
	gold = clamp(new_gold, 0, PlayerData.max_gold)
