extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pantry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://pantry.tscn") # Replace with function body.

func _on_cutting_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cutting.tscn") # Replace with function body.

func _on_stove_button_pressed() -> void:
	get_tree().change_scene_to_file("res://stove.tscn") # Replace with function body.

func _on_mixing_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mixing.tscn") # Replace with function body.

func _on_plating_button_pressed() -> void:
	get_tree().change_scene_to_file("res://plating.tscn") # Replace with function body.

func _on_exit_button_pressed() -> void:
	# Quits Application
	get_tree().quit()
