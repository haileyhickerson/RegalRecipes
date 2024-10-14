extends Node2D


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


# Recipe 1
func _on_recipe_1_button_pressed() -> void:
	# Proceeds to Kitchen Scene
	get_tree().change_scene_to_file("res://intro.tscn")

# Recipe 2
func _on_recipe_2_button_pressed() -> void:
	# Do nothing for now
	pass

# Recipe 3
func _on_recipe_3_button_pressed() -> void:
	# Do nothing for now
	pass

# Back Button
func _on_back_button_pressed() -> void:
	# Returns to main menu scene
	get_tree().change_scene_to_file("res://main_menu.tscn")
