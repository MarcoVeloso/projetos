extends VBoxContainer

var default_text = ""

onready var timer = $Timer
onready var label = $Label
onready var button = $Button
onready var secretButton = $SecretButton

func _process(delta):
	if timer.time_left > 0:
		label.text = default_text + "%.2f" % (timer.time_left)

func show_game_over():
	label.text = "You lose"
	button.text = "Restart stage"
	button.show()
	self.show()
	
	yield(button, "pressed")
	
	self.hide()
	
func show_prepare_next_battle(show_secret_button):
	label.text = "Prepare to\nnext battle...\n"
	button.hide()
	secretButton.visible = show_secret_button
	self.show()
	
	default_text = label.text
	timer.start()
	yield(timer, "timeout")
	
	self.hide()
	
func show_stage_results(gold):
	label.text = "You beat the stage!\nTotal Gold: " + str(gold)
	button.text = "Go to next stage"
	button.show()
	self.show()
	
	yield(button, "pressed")
	self.hide()
