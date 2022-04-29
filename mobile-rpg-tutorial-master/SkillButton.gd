extends "res://SkillsActions.gd"

func _on_toggled(selected):	
	execute_skill(text)
	set_textbox("Triple Attack \nAttack 3 times in a row")
