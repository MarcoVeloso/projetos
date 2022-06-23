extends VBoxContainer

var default_text = ""

onready var timer = $Timer
onready var label = $Label
onready var restartButton = $RestartButton
onready var nextStageButton = $NextStageButton
onready var secretButton = $SecretButton

func _process(delta):
	if timer.time_left > 0:
		label.text = default_text + "%.2f" % (timer.time_left)


func show_prepare_next_battle(show_secret_button):
	restartButton.hide()
	nextStageButton.hide()
	secretButton.visible = show_secret_button
	
	secretButton.pressed = false
	
	label.text = "Prepare to\nnext battle...\n"

	self.show()
	
	default_text = label.text
	timer.start()
	yield(timer, "timeout")


func show_game_over():
	restartButton.show()
	nextStageButton.show()
	secretButton.hide()
	
	label.text = "You lose..."

	self.show()


func show_stage_results(gold):
	restartButton.show()
	nextStageButton.show()
	secretButton.hide()
	
	label.text = "You beat the stage!\nTotal $: " + str(gold)

	self.show()
