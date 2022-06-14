extends Panel

onready var HPbar = $HPBar
onready var hpLabel = $HP
onready var apLabel = $AP
onready var atkLabel = $ATK
onready var magLabel = $MAG
onready var playerSprite = $Sprite


func _on_Player_stat_changed(stat, value):
	updateLabels(stat, value)

	
func updateLabels(stat, value):
	match stat:
		"hp":
			hpLabel.text = str(value)
			HPbar.value = value
		"ap":
			apLabel.text = GameData.icon.AP + str(value)
		"atk":
			atkLabel.text = GameData.icon.ATK + str(value)
		"mag":
			magLabel.text = GameData.icon.MAG + str(value)


func _on_Player_update_player_face(type):
	var anim_begin = "hurt"
	var anim_end = "stand"
	
	match type:
		"normal":
			anim_begin = "stand"
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
