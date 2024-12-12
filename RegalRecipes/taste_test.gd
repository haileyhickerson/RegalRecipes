extends Node2D

func _ready():
	
	if PlayerVariables.curr_recipe == 0:
		$Recipe1.show()
	if PlayerVariables.curr_recipe == 1:
		$Recipe2.show()
	if PlayerVariables.curr_recipe == 2:
		$Recipe3.show()

func _process(delta: float) -> void:
	await get_tree().create_timer(3.0).timeout
	if PlayerVariables.final_score <= 200:
		$AngryKing.show()
	if PlayerVariables.final_score > 200 and PlayerVariables.final_score <= 350:
		$MidKing.show()
	if PlayerVariables.final_score > 350:
		$HappyKing.show()
	await get_tree().create_timer(1.0).timeout
	$"Next Button".show()
	
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn")


func _on_next_button_pressed()-> void:
	get_tree().change_scene_to_file("res://final_score.tscn")
	
	
