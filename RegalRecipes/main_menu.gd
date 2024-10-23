extends Node2D


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


# Start Button
func _on_start_button_pressed() -> void:
	# Proceeds to Recipe Selection Scene
	get_tree().change_scene_to_file("res://character_selection.tscn")

# Quit Button
func _on_quit_button_pressed() -> void:
	# Quits Application
	get_tree().quit()
