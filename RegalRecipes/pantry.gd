extends Node2D
var baskets
var ingredient_list
var selected_ingredients = []
var correct_ingredients = ["Carrot1", "Ham1"]

func _ready() -> void:
	baskets = get_tree().get_nodes_in_group("basket")
	ingredient_list = get_tree().get_nodes_in_group("ingredients")
	if $NextButton != null:
		$NextButton.hide()
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
		# Loop through all ingredients to check which one was clicked
			for ingredient in ingredient_list:
				if ingredient.get_rect().has_point(ingredient.to_local(event.position)):
					print("Clicked on: " + ingredient.name) # Debugging: print the clicked ingredient's name
					# You can now handle the click logic here (e.g., start dragging)
					if ingredient.name in correct_ingredients:
						selected_ingredients.append(ingredient.name)
						ingredient.speed = 0
						print(ingredient.name)
						update_progress(ingredient.name)
						if len(selected_ingredients) == 2:
							$NextButton.show()

func update_progress(ingredient_name: String):
	if get_node("VBoxContainer/" + ingredient_name + "_label") != null:
		var progress_label = get_node("VBoxContainer/" + ingredient_name + "_label")
		progress_label.text = ingredient_name.capitalize() + ": 1/1"
		progress_label.modulate = Color(0, 1, 0)  # Green color

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://kitchen.tscn")


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.
