extends Control

onready var req = $Panel/Req
onready var desc = $Panel/VBox/Description
onready var button = $Panel/Button
onready var buttonText = $Panel/Button/Text

var skill = null
var skill_name = ""
var index_next = 0


func drawSkill(skillname, data):
	skill = data
	skill_name = skillname
	index_next = 0

	var desc_text = skill.title
	var cost_text = "$"
	var cost = 0
	var req_ok = false
	
	if skill.values:
		req_ok = true
		index_next = skill.values.find(PlayerData[skill_name]) + 1
		desc_text += " (" + str(skill.values[index_next]) + ")"

	if skill.req:
		var req = skill.req.split(" ")

		if int(req[0]) <= PlayerData[req[1]]:
			req_ok = true
			
		for stat in PlayerData.stats:
			if stat in skill.req:
				cost_text += "\n" + skill.req.replace(" " + stat, GameData.stats_icon[stat])

	cost = skill.costs[index_next]
	cost_text = str(cost) + cost_text
	desc_text += "\n" + skill.desc
	
	desc.bbcode_text = desc_text
	buttonText.text = cost_text

	button.disabled = false
	buttonText.modulate = Color(1,1,1,1)
	
	if cost > PlayerData.gold or !req_ok:
		button.disabled = true
		buttonText.modulate = Color(0.5,0.5,0.5,1)


func _on_Button_pressed():
	PlayerData.gold -= skill.costs[index_next]
	
	if index_next > 0:
		PlayerData[skill_name] = skill.values[index_next]
	else:
		setPlayerSkill(skill_name,null)
		skill.costs = null

	get_tree().reload_current_scene()
	
	
func setPlayerSkill(skill, index):
	if !index:
		index = PlayerData.selected_skills.find(null)
		
	PlayerData.selected_skills[index] = skill
	
