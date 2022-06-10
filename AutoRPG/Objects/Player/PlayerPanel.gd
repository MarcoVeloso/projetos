extends Panel

onready var hpLabel = $HP
onready var apLabel = $AP
onready var HPbar = $HPBar
onready var playerSprite = $Sprite

func _ready():
	_on_Player_init_player()
	
func _on_Player_init_player():
	playerSprite.play("stand")
	HPbar.max_value = PlayerData.max_hp
	updateHP(PlayerData.max_hp)
	updateAP(PlayerData.start_ap)
	
func _on_Player_hp_changed(value):
	updateHP(value)

func _on_Player_ap_changed(value):
	updateAP(value)
	
func updateHP(value):
	hpLabel.text = str(value)
	HPbar.value = value
	
func updateAP(value):
	apLabel.text = GameData.icon.AP + ' ' + str(value)

func _on_Player_update_player_face(type):
	var anim_begin = "hurt"
	var anim_end = "stand"
	
	match type:
		"weak":
			anim_end = "tired"
		"die":
			anim_end = "die"
		"happy":
			anim_begin = "smile"
		"stayhappy":
			anim_begin = "smile"
			anim_end = "smile"
		"shield":
			anim_end = "defend"
		
	playerSprite.play(anim_begin)
	yield(playerSprite, "animation_finished")
	playerSprite.play(anim_end)
