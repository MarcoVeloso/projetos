extends VBoxContainer

var default_text = ""

onready var timer = $Timer
onready var label = $Label
onready var button = $Button

func _process(delta):
	if timer.time_left > 0:
		label.text = default_text + "%.2f" % (timer.time_left)

func show_game_over():
	label.text = "You lose"
	button.text = "Restart stage"
	self.show()
	
	yield(button, "pressed")
	
	self.hide()
	
func show_prepare_next_battle():
	label.text = "Prepare to\nnext battle...\n"
	button.text = "Restart stage"
	self.show()
	
	default_text = label.text
	timer.start()
	yield(timer, "timeout")
	
	self.hide()
	
func show_stage_results(gold):
	label.text = "You beat the stage!\nTotal Gold: " + str(gold)
	button.text = "Go to next stage"
	self.show()
	
	yield(button, "pressed")
	self.hide()