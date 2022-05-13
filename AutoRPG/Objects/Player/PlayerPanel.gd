extends Panel

onready var hpLabel = $HP
onready var apLabel = $AP
onready var HPbar = $HPBar
onready var playerSprite = $Sprite

func _ready():
	_on_PlayerStats_init_player()
	
func _on_PlayerStats_init_player():
	playerSprite.play("stand")
	HPbar.max_value = PlayerData.max_hp
	updateHP(PlayerData.max_hp)
	updateAP(PlayerData.max_ap)
	
func _on_PlayerStats_hp_changed(value):
	updateHP(value)
	
	playerSprite.play("hurt")
	yield(playerSprite, "animation_finished")
	playerSprite.play("stand")

func _on_PlayerStats_ap_changed(value):
	updateAP(value)
	
func updateHP(value):
	hpLabel.text = str(value)
	HPbar.value = value
	
func updateAP(value):
	apLabel.text = "AP: " + str(value)
