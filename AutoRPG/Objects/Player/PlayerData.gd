extends Node

var max_hp = 10
var max_ap = 100
var start_ap = 100
var max_gold = 100
var attack_power = 1
var magic_power = 1

var stages_unlocked = {
	"11":{"name":"Tutorial","best_gold":30},
	"12":{"name":"Green Fields 1","best_gold":60},
	"13":{"name":"Green Fields 2","best_gold":90},
	"14":{"name":"Green Fields 3","best_gold":0},
}

var passive_skill = "Attack First"
#var passive_skill = "Attack Boost"
#var passive_skill = "Magic Boost"
#var passive_skill = "AP Gain Boost"

var selected_skills = ["SLASH", "HEAL", "DEFEND", "SWIFT", "CROSS", "CRESCENT", "EXPLOSION", "ULTIMA"]
#var selected_skills = ["SLASH", "HEAL", null, null, null, null, null, null]
