extends Control

onready var title = $Title
onready var gold = $Gold
onready var buttonLeft = $ButtonLeft
onready var buttonRight = $ButtonRight


func _ready():
	var menu = get_parent().name
	
	title.text = menu.to_upper()
	
	buttonLeft.text = "← " + GameData.menus[menu].left
	buttonRight.text = GameData.menus[menu].right + " →"


func goto_menu(menu):
	SceneTransition.transition_dissolve(GameData.menus[menu].scene)


func _on_ButtonLeft_pressed():
	var menu = buttonLeft.text.replace("← ","")
	goto_menu(menu)


func _on_ButtonRight_pressed():
	var menu = buttonRight.text.replace(" →","")
	goto_menu(menu)
