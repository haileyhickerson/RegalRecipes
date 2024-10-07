extends Node2D


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass

#
func _on_pantry_button_pressed() -> void:
	# Changes to pantry scene
	get_tree().change_scene_to_file("res://pantry.tscn") 

func _on_cutting_button_pressed() -> void:
	# Changes to cutting scene
	get_tree().change_scene_to_file("res://cutting.tscn") 

func _on_stove_button_pressed() -> void:
	# Changes to stove scene
	get_tree().change_scene_to_file("res://stove.tscn") 
	
func _on_mixing_button_pressed() -> void:
	# Changes to mixing scene
	get_tree().change_scene_to_file("res://mixing.tscn") 

func _on_plating_button_pressed() -> void:
	# Changes to plating scene
	get_tree().change_scene_to_file("res://plating.tscn") 

func _on_exit_button_pressed() -> void:
	# Quits Application
	get_tree().quit()
