extends Node2D

#var final_score = PlayerVariables.pantry_score + PlayerVariables.cutting_score + PlayerVariables.mixing_score + PlayerVariables.stove_score + PlayerVariables.plating_score

func _ready():
	$IngredientSelection/PantryScore.text = str(PlayerVariables.pantry_score) + " / 100"
	$Chopping/CuttingScore.text = str(PlayerVariables.cutting_score) + " / 100"
	$Mixing/MixingScore.text = str(PlayerVariables.mixing_score) + " / 100"
	$Cooking/CookingScore.text = str(PlayerVariables.stove_score) + " / 100"
	$Plating/PlatingScore.text = str(PlayerVariables.plating_score) + " / 100"
	
	$Total/TotalScore.text = str(PlayerVariables.final_score) + " / 500"
	
func _on_back_button_pressed()-> void:
	get_tree().change_scene_to_file("res://recipe_selection.tscn")
	
	if PlayerVariables.final_score > 0:
		PlayerVariables.recipe1_completed = true
	
	# Resets all variables
	PlayerVariables.pantry_completed = false
	PlayerVariables.cutting_completed = false
	PlayerVariables.mixing_completed = false
	PlayerVariables.stove_completed = false
	PlayerVariables.plating_completed = false
	PlayerVariables.pantry_score = 0
	PlayerVariables.cutting_score = 0
	PlayerVariables.mixing_score = 0
	PlayerVariables.stove_score = 0
	PlayerVariables.plating_score = 0
	PlayerVariables.final_score = 0
