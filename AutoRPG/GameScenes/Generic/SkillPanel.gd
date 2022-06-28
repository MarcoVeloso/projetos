extends Control

onready var title = $Panel/Title
onready var req = $Panel/Req
onready var desc = $Panel/Description
onready var button = $Panel/Button
onready var buttonText = $Panel/Button/Text

var skill = null

func _ready():
	skill = ShopData.data[self.name]
	
	drawSkill()


func drawSkill():
	title.bbcode_text = skill.title + str(skill.increment)
	desc.bbcode_text = skill.desc
	buttonText.text = "$\n" + str(skill.cost)

	if skill.cost > PlayerData.gold:
		button.disabled = true
		buttonText.modulate = Color(0.5,0.5,0.5,1)


func _on_Button_pressed():
	pass
#	if skill.increment:
		
