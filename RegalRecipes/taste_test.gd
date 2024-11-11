extends Node2D

func _ready():
	if PlayerVariables.final_score <= 200:
		$AngryKing.show()
	if PlayerVariables.final_score > 200 and PlayerVariables.final_score <= 350:
		$MidKing.show()
	if PlayerVariables.final_score > 350:
		$HappyKing.show()
	
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn")


func _on_next_button_pressed()-> void:
	get_tree().change_scene_to_file("res://final_score.tscn")
	
	
