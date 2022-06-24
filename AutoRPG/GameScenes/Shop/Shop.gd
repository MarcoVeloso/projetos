extends Node

onready var playerPanel = $UI/PlayerPanel

func _ready():
	playerPanel.updatePanel()

