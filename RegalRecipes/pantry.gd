extends Node2D
var ingredient_list
var selected_ingredients = []
var correct_ingredients = PlayerVariables.correct_ingredients[PlayerVariables.curr_recipe]
var starting_score = 100
var dialogue_index = 0
var instructions = ["Drag the correct ingredients into the basket!", "If you click the wrong ingredient, you lose points!"]

func _ready() -> void:
	if $ScoreTextbox != null:
		$ScoreTextbox.hide()
	if $NextButton != null:
		$NextButton.hide()
	ingredient_list = get_tree().get_nodes_in_group("ingredients")
	if $InstructionsTextbox != null:
		if PlayerVariables.curr_recipe == 0:
			$InstructionsTextbox/ExampleOnion.hide()
			$InstructionsTextbox/ExampleCarrot.hide()
		elif PlayerVariables.curr_recipe == 1:
			$InstructionsTextbox/ExampleHam.hide()
			$InstructionsTextbox/ExamplePea.hide()
		set_display()
	show_next_dialogue()

func show_next_dialogue():
	if dialogue_index < instructions.size():
		if $InstructionsTextbox != null:
			$InstructionsTextbox/InstructionText.text = instructions[dialogue_index]  # Updates the label with the current dialogue
			dialogue_index += 1
	else:
		$InstructionsTextbox.hide() 
	
func _input(event):
	if event.is_action_pressed("action"):
		if $InstructionsTextbox != null:
			$InstructionsTextbox/ExampleHam.hide()
			$InstructionsTextbox/ExamplePea.hide()
			show_next_dialogue()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
		# Loop through all ingredients to check which one was clicked
			for ingredient in ingredient_list:
				if ingredient.get_rect().has_point(ingredient.to_local(event.position)):
					print("Clicked on: " + ingredient.name) # Debugging: print the clicked ingredient's name
					# You can now handle the click logic here (e.g., start dragging)
					if ingredient.name in correct_ingredients:
						print("yes!")
						selected_ingredients.append(ingredient.name)
						ingredient.speed = 0
						print(ingredient.name)
						update_progress(ingredient.name)
						if len(selected_ingredients) == 2:
							$ScoreTextbox/Score.text = str(starting_score) + " points! Great job!"
							$ScoreTextbox.show()
							$NextButton.show()
							PlayerVariables.pantry_completed = true
							PlayerVariables.pantry_score = starting_score
					else:
						print("No!")
						starting_score -= 10
						if starting_score < 0:
							starting_score = 0
					update_score()

func update_score():
	if $ScoreDisplay.text != null:
		$ScoreDisplay.text = "Score: " + str(starting_score)

func set_display():
	if get_node("VBoxContainer") != null:
		get_node("VBoxContainer/ingredient_label1").text = correct_ingredients[0] + ": 0/1"
		get_node("VBoxContainer/ingredient_label2").text = correct_ingredients[1] + ": 0/1"
	
func update_progress(ingredient_name: String):
	if get_node("VBoxContainer") != null:
		if get_node("VBoxContainer/ingredient_label1").text == ingredient_name + ": 0/1":
			get_node("VBoxContainer/ingredient_label1").text = ingredient_name.capitalize() + ": 1/1"
			get_node("VBoxContainer/ingredient_label1").modulate = Color(0, 1, 0)
		else:
			get_node("VBoxContainer/ingredient_label2").text = ingredient_name.capitalize() + ": 1/1"
			get_node("VBoxContainer/ingredient_label2").modulate = Color(0, 1, 0)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://kitchen.tscn")


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.
