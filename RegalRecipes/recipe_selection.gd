extends Node2D


func _ready() -> void:
	if PlayerVariables.recipe1_completed:
		$Recipe2Button.add_theme_color_override("font_color", "White")
	if PlayerVariables.recipe2_completed:
		$Recipe3Button.add_theme_color_override("font_color", "White")
	PlayerVariables.location = Vector2(400, 400)
func _process(delta: float) -> void:
	pass


# Recipe 1
func _on_recipe_1_button_pressed() -> void:
	# Updates which recipe is selected, 0th indexing
	PlayerVariables.curr_recipe = 0
	PlayerVariables.pantry_completed = false
	PlayerVariables.cutting_completed = false
	PlayerVariables.mixing_completed = false
	PlayerVariables.stove_completed = false
	PlayerVariables.plating_completed = false
	if PlayerVariables.intro_completed != true:
		get_tree().change_scene_to_file("res://intro.tscn")
	else:
		get_tree().change_scene_to_file("res://kitchen.tscn")
		

# Recipe 2
func _on_recipe_2_button_pressed() -> void:
	# If score achieved on recipe 1, allow recipe 2 to be clicked
	if PlayerVariables.recipe1_completed:
		PlayerVariables.curr_recipe = 1
		PlayerVariables.pantry_completed = false
		PlayerVariables.cutting_completed = false
		PlayerVariables.mixing_completed = false
		PlayerVariables.stove_completed = false
		PlayerVariables.plating_completed = false
		get_tree().change_scene_to_file("res://kitchen.tscn")
# Recipe 3
func _on_recipe_3_button_pressed() -> void:
	# Do nothing for now
	if PlayerVariables.recipe2_completed:
		PlayerVariables.curr_recipe = 2
		get_tree().change_scene_to_file("res://kitchen.tscn")

# Back Button
func _on_back_button_pressed() -> void:
	# Returns to main menu scene
	get_tree().change_scene_to_file("res://main_menu.tscn")
