extends VBoxContainer

const default_text = "Prepare to\nnext battle...\n"

onready var timer = $Timer
onready var prepareNextBattle = $PrepareNextBattle
onready var restartButton = $RestartButton

func _process(delta):
	if timer.time_left > 0:
		prepareNextBattle.text = default_text + "%.2f" % (timer.time_left)

func show_game_over():
	prepareNextBattle.hide()
	self.show()
	yield(restartButton, "pressed")
	self.hide()
	
func show_prepare_next_battle():
	prepareNextBattle.show()
	self.show()
	timer.start()
	yield(timer, "timeout")
	self.hide()
