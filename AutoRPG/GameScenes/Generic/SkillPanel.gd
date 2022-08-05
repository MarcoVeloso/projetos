extends Control

onready var req = $Panel/Req
onready var desc = $Panel/VBox/Description
onready var button = $Panel/Button
onready var buttonText = $Panel/Button/Text

var skill = null
var skill_name = ""
var index_next = 0


func loadItems(items):
	button.loadItems(items)


func drawSkill(skillname, data):
	skill = data
	skill_name = skillname
	index_next = 0

	var desc_text = skill.title
	var button_text = "$"
	var req_ok = true

	if skill.costs:
		var cost = 0
		
		if skill.values:
			index_next = skill.values.find(PlayerData[skill_name]) + 1
			desc_text += " (" + str(skill.values[index_next]) + ")"

		if skill.req:
			var req = skill.req.split(" ")

			if int(req[0]) > PlayerData[req[1]]:
				req_ok = false

			for stat in PlayerData.stats:
				if stat in skill.req:
					button_text += "\n" + skill.req.replace(" " + stat, GameData.stats_icon[stat])

		cost = skill.costs[index_next]
		button_text = str(cost) + button_text
		
		if cost > PlayerData.gold:
			req_ok = false

	else:
		button_text = GameData.icon.LIST

	desc_text += "\n" + skill.desc

	desc.bbcode_text = desc_text
	buttonText.text = button_text

	if req_ok:
		button.disabled = false
		buttonText.modulate = Color(1,1,1,1)
	else:
		button.disabled = true
		buttonText.modulate = Color(0.5,0.5,0.5,1)


func _on_Button_pressed():
	if skill.costs:
		PlayerData.gold -= skill.costs[index_next]
		
		if index_next > 0:
			PlayerData[skill_name] = skill.values[index_next]
		else:
			PlayerData.setPlayerSkill(skill_name)
			skill.costs = null

		get_tree().reload_current_scene()
	else:
		print("eh setup")
