extends Node2D

var instructions = ["Set each knob to the right temperature!", "If you mess up, you have to start over!"]
var spoonhead_dialogue = ["", "Nice!", "Well done!", "Almost there!"]
var spoonhead_bad_text = ["", "No!", "Aargh!", "You had it!", "So close!"]
var dialogue_index = 0
var curr_knob = 1
var score = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NextButton.hide()
	$FancyCircle.hide()
	$ChefText.hide()
	$ButterspoonHead.hide()
	$OvenTrayholder.hide()
	$ScoreTextBox.hide()
	show_next_dialogue()


func show_next_dialogue():
	if dialogue_index < instructions.size():
		$TextBox/Instructions.text = instructions[dialogue_index]  # Updates the label with the current dialogue
		dialogue_index += 1
	else:
		$TextBox.hide() 
		$ScoreDisplay.show()
		$knob1.can_click = true
		$knob2.can_click = true
		$knob3.can_click = true
		$knob4.can_click = true

func butterspoon_good():
	$FancyCircle.show()
	$ButterspoonHead.show()
	if curr_knob < 4:
		$ChefText/Text.text = spoonhead_dialogue[curr_knob]
	$ChefText.show()
	if curr_knob == 1:
		$knob1.knob1_completed = true
	elif curr_knob == 2:
		$knob2.knob2_completed = true
	elif curr_knob == 3:
		$knob3.knob3_completed = true
	else:
		$knob4.knob4_completed = true
	curr_knob += 1

func butterspoon_bad():
	$FancyCircle.show()
	$ButterspoonHead.show()
	$ChefText/Text.text = spoonhead_bad_text[curr_knob]
	$ChefText.show()
	if curr_knob == 1:
		score -= 5
	elif curr_knob == 2:
		score -= 3
	elif curr_knob == 3:
		score -= 2
	else:
		score -= 1
	$knob1.knob1_completed = false
	$knob2.knob2_completed = false
	$knob3.knob3_completed = false
	$knob4.knob4_completed = false
	curr_knob = 1
	update_score()


func _input(event):
	if event.is_action_pressed("action"):
		$TextBox/KnobExamples.hide()
		show_next_dialogue()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if curr_knob > 4:
		$FancyCircle.hide()
		$ButterspoonHead.hide()
		$ChefText.hide()
		$OvenTrayholder.show()
		$OvenTrayholder/OvenTray.play()
		$ScoreTextBox/Score.text = str(score) + " points!"
		PlayerVariables.stove_score = score
		$ScoreTextBox.show()
		$NextButton.show()
		
func update_score():
	if $ScoreDisplay.text != null:
		$ScoreDisplay.text = "Score: " + str(score)


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.
