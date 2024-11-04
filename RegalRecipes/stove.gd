extends Node2D

# Variables to control cooking stages
var correct_temp = true
var cooking_started = false
var flip_allowed = false
var undercooked = false
var overcooked = false
var is_mouse_over = false
var flipped = false
var temp_score
var flip_score
var cook_score
@onready var meat_animated_sprite = $Bacon/BaconAnimation
var dialogue_index = 0
var instructions = ["Click on the knob at the right temperature.", "Once the bar reaches 50%, click the PAN HANDLE to flip the meat!", "Make sure the meat isn't undercooked or overcooked!", "Well done! You cooked the meat perfectly!"]

func _ready() -> void:
	$FlipText.hide()
	$NextButton.hide()
	$TextBox/KnobExample.show()
	show_next_dialogue()

func show_next_dialogue():
	if dialogue_index < instructions.size() - 1:
		$TextBox/Instructions.text = instructions[dialogue_index]  # Updates the label with the current dialogue
		dialogue_index += 1
	else:
		$TextBox.hide() 

# Start cooking when the correct temperature is set
func start_cooking():
	$CookingBar.visible = true
	cooking_started = true
	$CookingBar.value = 0  # Reset the progression bar

	# Start a timer or increment the bar in _process()
	set_process(true)

func _input(event):
	if event.is_action_pressed("click") and is_mouse_over and flipped == false:
		on_pan_click()
	if event.is_action_pressed("action"):
		$TextBox/KnobExample.hide()
		show_next_dialogue()

func on_pan_click():
	flipped = true
	if flip_allowed:
		print("Meat flipped!")
		flip_allowed = false
		meat_animated_sprite.play("cooked")
		print($StoveKnob.rotation)
		$CookingBar.value = 60
		$FlipText.hide()
	else:
		print("Too early! Meat is undercooked.")
		undercooked = true
		end_cooking()

# Handle cooking progression in _process()
func _process(delta):
	if cooking_started:
		# Increase the progression bar gradually (this can be adjusted)
		$CookingBar.value += 10 * delta

		# Flip allowed around 50% of the bar (adjust as needed)
		if $CookingBar.value >= 50 and $CookingBar.value <= 60:
			flip_allowed = true
			$FlipText.show()

		# Check if flip point has passed without action
		elif $CookingBar.value > 60 and flip_allowed:
			overcooked = true
			end_cooking()

		# Complete cooking when the bar is full
		if $CookingBar.value >= 100:
			end_cooking()

# End cooking and calculate score
func end_cooking():
	cooking_started = false
	flip_allowed = false
	set_process(false)

	# Score logic
	var score = calculate_score(correct_temp, !undercooked, !overcooked)
	print("Final Score:", score)
	$TextBox/Instructions.text = instructions[dialogue_index] 
	$TextBox.show()
	$NextButton.show()

func calculate_score(temp_correct: bool, flip_correct: bool, perfect_cook: bool) -> int:
	if temp_correct:
		temp_score = 50
	else:
		temp_score = 0
	if flip_correct:
		flip_score = 50
	else:
		flip_score = 0
	if perfect_cook:
		cook_score = 50
	else:
		cook_score = 0
	print(temp_score)
	return temp_score + flip_score + cook_score

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.

func _on_pan_mouse_entered() -> void:
	is_mouse_over = true # Replace with function body.

func _on_pan_mouse_exited() -> void:
	is_mouse_over = false # Replace with function body.

func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.
