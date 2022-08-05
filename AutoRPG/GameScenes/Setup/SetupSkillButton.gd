extends MenuButton

var popup

func _ready():
	popup = self.get_popup()
	popup.connect("index_pressed", self, "_on_index_pressed")
	
func loadItems(items):
	for item in items:
		popup.add_item(item)

func _on_index_pressed(index):
	print(popup.get_item_text(index), " pressed")


