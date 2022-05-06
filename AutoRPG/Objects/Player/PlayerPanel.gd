extends Panel

onready var hpLabel = $HP
onready var apLabel = $AP
onready var HPbar = $HPBar

#func _ready():
#	HPbar.max_value = hp

func _on_PlayerStats_hp_changed(value):
	hpLabel.text = str(value)
	HPbar.value = value

func _on_PlayerStats_ap_changed(value):
	apLabel.text = "AP: " + str(value)
