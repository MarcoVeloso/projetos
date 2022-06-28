extends Node

const stats = ["HP", "AP", "ATK", "MAG", "WALLET"]

var HP = 10
var AP = 5
var WALLET = 100
var ATK = 1
var MAG = 1

var start_ap = 1
var gold = 0 setget set_gold
var current_stage = "11"

var stages_unlocked = {
	"11":{"best_gold":""},
}

var passive_skill = "Attack First"
#var passive_skill = "Attack Boost"
#var passive_skill = "Magic Boost"
#var passive_skill = "AP Gain Boost"

var selected_skills = ["SLASH", "HEAL", "DEFEND", "SWIFT", "CROSS", "CRESCENT", "EXPLOSION", "ULTIMA"]
#var selected_skills = ["SLASH", "HEAL", null, null, null, null, null, null]


func set_gold(new_gold):
	gold = clamp(new_gold, 0, PlayerData.WALLET)
