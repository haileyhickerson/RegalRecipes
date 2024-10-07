extends Node2D

var in_pantry = false
# Called when the node enters the scene tree for the first time.
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.
