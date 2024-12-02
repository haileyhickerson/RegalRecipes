extends Node2D

var instructions = []
var recipe2 = ["Now, let's bake our potato!", "Click on each knob to set the temperature!", "You must go from left to right!", "If you mess up, you have to start over!"]
var recipe3 = ["Now, let's bake our cake!", "Set the knobs to the perfect temperature!"]
var spoonhead_dialogue = ["", "Nice!", "Well done!", "Almost there!"]
var spoonhead_bad_text = ["", "No!", "Aargh!", "You had it!", "So close!"]
var dialogue_index = 0
var curr_knob = 1
var score = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PlayerVariables.curr_recipe == 1:
		instructions = recipe2
	else:
		instructions = recipe3
	$NextButton.hide()
	$TextBox/KnobExamples.hide() 
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
		$TextBox/KnobExamples.hide() 
		$ScoreDisplay.show()
		$knob1.can_click = true

func butterspoon_good():
	$FancyCircle.show()
	$ButterspoonHead.show()
	if curr_knob < 4:
		$ChefText/Text.text = spoonhead_dialogue[curr_knob]
	$ChefText.show()
	if curr_knob == 1:
		$knob1.knob1_completed = true
		$knob1.can_click = false
		$knob2.can_click = true
	elif curr_knob == 2:
		$knob2.knob2_completed = true
		$knob2.can_click = false
		$knob3.can_click = true
	elif curr_knob == 3:
		$knob3.knob3_completed = true
		$knob3.can_click = false
		$knob4.can_click = true
	else:
		$knob4.knob4_completed = true
		$knob4.can_click = false
	$CorrectSound.play()
	curr_knob += 1

func butterspoon_bad():
	$FancyCircle.show()
	$ButterspoonHead.show()
	$ChefText/Text.text = spoonhead_bad_text[curr_knob]
	$ChefText.show()
	#print(curr_knob)
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
	$knob1.can_click = true
	$knob2.can_click = false
	$knob3.can_click = false
	$knob4.can_click = false
	curr_knob = 1
	update_score()


func _input(event):
	if event.is_action_pressed("action"):
		show_next_dialogue()
		$TextBox/KnobExamples.show() 
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if curr_knob > 4:
		$FancyCircle.hide()
		$ButterspoonHead.hide()
		$ChefText.hide()
		$OvenTrayholder.show()
		$OvenTrayholder/OvenTray.play()
		$ScoreTextBox/Score.text = str(score) + " points!"
		$ScoreTextBox.show()
		$NextButton.show()
		
func update_score():
	if $ScoreDisplay.text != null:
		if score < 0:
			score = 0
		$ScoreDisplay.text = "Score: " + str(score)


func _on_next_button_pressed() -> void:
	#print(PlayerVariables.stove_score)
	PlayerVariables.stove_completed = true
	PlayerVariables.stove_score += score
	#print(PlayerVariables.stove_score)
	if PlayerVariables.curr_recipe == 1:
		PlayerVariables.stove_score /= 2
	#print(PlayerVariables.stove_score)
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.
