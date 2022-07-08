extends MenuButton

func loadItems(items):
	for item in items:
		self.get_popup().add_item(item)

func _on_pressed():
	print(name)


