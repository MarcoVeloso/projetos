extends Node

const stats = ["HP", "AP", "ATK", "MAG", "WALLET"]

var HP = 10
var AP = 5
var WALLET = 1000
var ATK = 1
var MAG = 1

var gold = 1000 setget set_gold
var current_stage = "11"

var stages_unlocked = {
	"11":{"best_gold":""},
}

var passive_skill = "ATTACK_FIRST"

#var selected_skills = ["SLASH", "HEAL", "CRESCENT", "SWIFT", "CROSS", "DEFEND", "EXPLOSION", "ULTIMA"]
var selected_skills = ["SLASH", "HEAL", null, null, null, null, null, null]

var shop_data = {}

func set_gold(new_gold):
	gold = clamp(new_gold, 0, PlayerData.WALLET)
