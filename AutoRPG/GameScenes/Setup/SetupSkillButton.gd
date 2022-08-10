extends MenuButton

var popup

 
func _ready():
	popup = self.get_popup()
	popup.connect("index_pressed", self, "_on_index_pressed")
	popup.connect("visibility_changed", self, "_on_visibility_changed")


func loadItems(items):
	for item in items:
		popup.add_item(item)


func _on_index_pressed(index):
	var skill = popup.get_item_text(index)
	var setup = get_node("/root/Setup")
	
	if "ActivesPanel" in str(get_path()):
		PlayerData.setPlayerSkill(skill, self.name)
		setup.updateSkillsScreen(skill)
	else:
		PlayerData.setPlayerPassive(skill)
		setup.updatePassiveDescription(skill)


func _on_visibility_changed():
	popup.rect_position.y -= 10

	if popup.rect_position.x > 30:
		popup.rect_position.x = 4
	else:
		popup.rect_position.x = 46
