extends MenuButton

onready var popup = self.get_popup()
onready var setup = get_node("/root/Setup")

 
func _ready():
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
		yield(get_tree().create_timer(0.01), "timeout")
		self.emit_signal("pressed")
	else:
		PlayerData.setPlayerPassive(skill)
		setup.updatePassiveDescription(skill)


func _on_visibility_changed():
	if popup.visible:
		popup.rect_position.y = self.rect_global_position.y

		if popup.rect_position.x > 30:
			popup.rect_position.x = 4
		else:
			popup.rect_position.x = 46


func _on_pressed():
	self.pressed = true
	setup.updateSkillDescription(self.text)
