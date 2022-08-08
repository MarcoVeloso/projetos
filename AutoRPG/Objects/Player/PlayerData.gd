extends Node

const stats = ["HP", "AP", "ATK", "MAG", "WALLET"]

var HP = 10
var AP = 5
var WALLET = 9999
var ATK = 10
var MAG = 10

var gold = 9999 setget set_gold
var current_stage = "11"

var stages_unlocked = {
	"11":{"best_gold":""},
}

var passive_skill = "Attack First"

var selected_skills = ["SLASH", "HEAL", null, null, null, null, null, null]

var shop_data = {}


func set_gold(new_gold):
	gold = clamp(new_gold, 0, PlayerData.WALLET)


func setPlayerSkill(skill, index=null):
	if index:
		var idx = int(index)
		
		var old_idx = selected_skills.find(skill)
		
		if old_idx >= 0:
			selected_skills[old_idx] = selected_skills[idx]
		
		selected_skills[idx] = skill
	else:
		var null_index = selected_skills.find(null)
		
		if null_index > 1 and skill in shop_data["skills"]:
			selected_skills[null_index] = skill


func setPlayerPassive(passive):
	passive_skill = passive
