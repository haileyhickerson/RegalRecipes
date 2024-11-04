extends Node2D
var baskets
var ingredient_list
var selected_ingredients = []
var correct_ingredients = ["PeaBag", "Ham1"]
var starting_score = 100
var dialogue_index = 0
var instructions = ["Drag 1 Bag of Peas and 1 Ham into the basket!", "If you click the wrong ingredient, you lose points!"]

func _ready() -> void:
	if $ScoreTextbox != null:
		$ScoreTextbox.hide()
	baskets = get_tree().get_nodes_in_group("basket")
	ingredient_list = get_tree().get_nodes_in_group("ingredients")
	if $NextButton != null:
		$NextButton.hide()
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
					else:
						print("No!")
						starting_score -= 10
						if starting_score < 0:
							starting_score = 0

func update_progress(ingredient_name: String):
	if get_node("VBoxContainer/" + ingredient_name + "_label") != null:
		var progress_label = get_node("VBoxContainer/" + ingredient_name + "_label")
		progress_label.text = ingredient_name.capitalize() + ": 1/1"
		progress_label.modulate = Color(0, 1, 0)  # Green color

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://kitchen.tscn")


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.
