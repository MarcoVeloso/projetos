extends MenuButton

onready var popup = self.get_popup()
onready var setup = get_node("/root/Setup")
var popup_y_position

 
func _ready():
	popup.grow_vertical = Control.GROW_DIRECTION_BEGIN
	popup.connect("index_pressed", self, "_on_index_pressed")
	popup.connect("visibility_changed", self, "_on_visibility_changed")


func loadItems(items):
	for item in items:
		popup.add_item(item)


func _on_index_pressed(index):
	var skill = popup.get_item_text(index)
	
	if "ActivesPanel" in str(get_path()):
		PlayerData.setPlayerSkill(skill, self.name)
		setup.updateSkillsScreen()
	else:
		PlayerData.setPlayerPassive(skill)
		setup.updatePassiveDescription(skill)


func _on_visibility_changed():
	if self.text:
		setup.updateSkillDescription(self.text)
		
		if popup.visible:
			if popup_y_position:
				popup.rect_position.y = popup_y_position
			else:
				popup.rect_position.y -= 14
				popup_y_position = popup.rect_position.y
		else:
			yield(get_tree().create_timer(0.01), "timeout")
			self.pressed = true
			
	#		if popup.rect_position.x > 30:
	#			popup.rect_position.x = 4
	#		else:
	#			popup.rect_position.x = 46
