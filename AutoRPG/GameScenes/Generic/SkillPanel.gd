extends Control

onready var title = $Panel/Title
onready var req = $Panel/Req
onready var desc = $Panel/Description
onready var button = $Panel/Button
onready var buttonText = $Panel/Button/Text

var skill = null
var skill_name = null
var index_next = 0

func _ready():
	skill_name = self.name
	skill = ShopData.data[skill_name]
	
	drawSkill()


func drawSkill():
	var desc_text = skill.desc
	var cost = skill.costs[0]
	
	if skill.type == "stat":
		index_next = skill.values.find(PlayerData[skill_name]) + 1
		
		desc_text += str(skill.values[index_next])
		cost = skill.costs[index_next]
		
	title.bbcode_text = skill.title
	desc.bbcode_text = desc_text
	buttonText.text = "$\n" + str(cost)

	if cost > PlayerData.gold:
		button.disabled = true
		buttonText.modulate = Color(0.5,0.5,0.5,1)


func _on_Button_pressed():
	if skill.type == "stat":
		PlayerData[skill_name] = skill.values[index_next]

	PlayerData.gold -= skill.costs[index_next]
	get_tree().reload_current_scene()
