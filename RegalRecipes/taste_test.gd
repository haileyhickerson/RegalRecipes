extends Node2D

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn")


func _on_next_button_pressed()-> void:
	get_tree().change_scene_to_file("res://final_score.tscn")
	
	
