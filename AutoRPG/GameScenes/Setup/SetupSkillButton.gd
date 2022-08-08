extends MenuButton

var popup

func _ready():
	popup = self.get_popup()
	popup.connect("index_pressed", self, "_on_index_pressed")
	
func loadItems(items):
	for item in items:
		popup.add_item(item)

func _on_index_pressed(index):
	var skill = popup.get_item_text(index)
	
	if "ActivesPanel" in str(get_path()):
		PlayerData.setPlayerSkill(skill, self.name)
	else:
		PlayerData.setPlayerPassive(skill)
		
	get_tree().reload_current_scene()


