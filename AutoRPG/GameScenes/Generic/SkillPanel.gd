extends Control

onready var title = $Panel/Title
onready var req = $Panel/Req
onready var desc = $Panel/Description
onready var button = $Panel/Button
onready var buttonText = $Panel/Button/Text

var skill = null
var skill_name = ""
var index_next = 0


func drawSkill(data):
	skill = data
	skill_name = data.name
	index_next = 0

	var title_text = skill.title
	var cost_text = "$"
	var cost = 0
	
	if skill.values:
		index_next = skill.values.find(PlayerData[skill_name]) + 1
		title_text += " (" + str(skill.values[index_next]) + ")"

	if skill.req:
		cost_text += "\n" + skill.req
		
	cost = skill.costs[index_next]
	cost_text = str(cost) + cost_text
	
	title.bbcode_text = title_text
	desc.bbcode_text = skill.desc
	buttonText.text = cost_text

	button.disabled = false
	buttonText.modulate = Color(1,1,1,1)
	
	if cost > PlayerData.gold:
		button.disabled = true
		buttonText.modulate = Color(0.5,0.5,0.5,1)


func _on_Button_pressed():
	if index_next > 0:
		PlayerData[skill_name] = skill.values[index_next]
	else:
		PlayerData.shop_data[skill.type].erase(skill)
		
	PlayerData.gold -= skill.costs[index_next]
	get_tree().reload_current_scene()
