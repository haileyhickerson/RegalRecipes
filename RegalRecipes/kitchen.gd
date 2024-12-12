extends Node2D
var in_pantry = false
var in_cutting = false
var in_stove = false
var in_mixing = false
var in_plating = false
var in_exit = false


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	$ChefText/MoveText.hide()
	$ChefText/GoToPantry.hide()
	$ChefText/GoToCutting.hide()
	$ChefText/GoToMixing.hide()
	$ChefText/GoToStove.hide()
	$ChefText/GoToPlating.hide()
	
	$PantryArrow.show()
	$PantryArrow.play()
	$CuttingArrow.hide()
	$MixingArrow.hide()
	$StoveArrow.hide()
	$PlatingArrow.hide()
	
	
	$PantryArea/PantryIcon.play("normal")
	$PantryArea/PantryText.hide()
	
	$CuttingArea/CuttingIcon.play("normal")
	$CuttingArea/CuttingText.hide()
	
	$MixingArea/MixingIcon.play("normal")
	$MixingArea/MixingText.hide()
	
	$StoveArea/StoveIcon.play("normal")
	$StoveArea/StoveText.hide()
	
	$PlatingArea/PlatingIcon.play("normal")
	$PlatingArea/PlatingText.hide()
	
	


func _process(delta: float) -> void:
	if PlayerVariables.curr_recipe == 0:
		$FancyCircle.show()
		$ButterspoonHead.show()
		if Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			PlayerVariables.first_move = true
	else:
		PlayerVariables.first_move = true
		$FancyCircle.hide()
		$ButterspoonHead.hide()
	
	if not PlayerVariables.first_move:
		$ChefText/MoveText.show()
		
	if PlayerVariables.first_move:
		if PlayerVariables.curr_recipe == 0:
			$ChefText/MoveText.hide()
			$ChefText/GoToPantry.show()
		else:
			$ChefText.hide()
			
		
	if PlayerVariables.pantry_completed:
		$PantryArrow.hide()
		$CuttingArrow.show()
		$CuttingArrow.play()
		if PlayerVariables.curr_recipe == 0:
			$ChefText/GoToPantry.hide()
			$ChefText/GoToCutting.show()
		
	if PlayerVariables.cutting_completed:
		$CuttingArrow.hide()
		$MixingArrow.show()
		$MixingArrow.play()
		if PlayerVariables.curr_recipe == 0:
			$ChefText/GoToCutting.hide()
			$ChefText/GoToMixing.show()
		
	if PlayerVariables.mixing_completed:
		$MixingArrow.hide()
		$StoveArrow.show()
		$StoveArrow.play()
		if PlayerVariables.curr_recipe == 0:
			$ChefText/GoToMixing.hide()
			$ChefText/GoToStove.show()
		
	if PlayerVariables.stove_completed:
		$StoveArrow.hide()
		$PlatingArrow.show()
		$PlatingArrow.play()
		if PlayerVariables.curr_recipe == 0:
			$ChefText/GoToStove.hide()
			$ChefText/GoToPlating.show()
		
	
		
		
	if Input.is_action_pressed("action") and in_pantry:
		get_tree().change_scene_to_file("res://pantry.tscn")
		$PantryArea/PantryIcon.play("press")
		
	if Input.is_action_pressed("action") and in_cutting and PlayerVariables.pantry_completed:
		$CuttingArea/CuttingIcon.play("press")
		if PlayerVariables.curr_recipe == 0:
			get_tree().change_scene_to_file("res://cutting.tscn") 
		if PlayerVariables.curr_recipe == 1:
			get_tree().change_scene_to_file("res://cutting2.tscn")
		if PlayerVariables.curr_recipe == 2:
			get_tree().change_scene_to_file("res://cutting3.tscn")
			
			
	if Input.is_action_pressed("action") and in_mixing and PlayerVariables.pantry_completed and PlayerVariables.cutting_completed:
		$MixingArea/MixingIcon.play("press")
		if PlayerVariables.curr_recipe == 0:
			get_tree().change_scene_to_file("res://mixing.tscn") 
		if PlayerVariables.curr_recipe == 1:
			get_tree().change_scene_to_file("res://mixing2.tscn") 
		if PlayerVariables.curr_recipe == 2:
			get_tree().change_scene_to_file("res://mixing3.tscn") 
			
	if Input.is_action_pressed("action") and in_stove and PlayerVariables.pantry_completed and PlayerVariables.cutting_completed and PlayerVariables.mixing_completed:
		if PlayerVariables.curr_recipe == 0 or PlayerVariables.curr_recipe == 1:
			$StoveArea/StoveIcon.play("press")
			get_tree().change_scene_to_file("res://stove.tscn") 
		else:
			$StoveArea/StoveIcon.play("press")
			get_tree().change_scene_to_file("res://oven.tscn") 
	if Input.is_action_pressed("action") and in_plating and PlayerVariables.pantry_completed and PlayerVariables.cutting_completed and PlayerVariables.mixing_completed and PlayerVariables.stove_completed:
		$PlatingArea/PlatingIcon.play("press")
		if PlayerVariables.curr_recipe == 0:
			get_tree().change_scene_to_file("res://plating.tscn") 
		if PlayerVariables.curr_recipe == 1:
			get_tree().change_scene_to_file("res://plating2.tscn")
		if PlayerVariables.curr_recipe == 2:
			get_tree().change_scene_to_file("res://cake_layers.tscn")

func _on_pantry_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and not PlayerVariables.pantry_completed:
		$PantryArea/PantryText.show()
		$PantryArea/PantryIcon.play("hover")
		in_pantry = true
func _on_pantry_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		$PantryArea/PantryText.hide()
		$PantryArea/PantryIcon.play("normal")
		in_pantry = false
func _on_cutting_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and PlayerVariables.pantry_completed  and not PlayerVariables.cutting_completed:
		$CuttingArea/CuttingText.show()
		$CuttingArea/CuttingIcon.play("hover")
		in_cutting = true 
func _on_cutting_area_area_exited(area: Area2D) -> void:
	$CuttingArea/CuttingText.hide()
	if area.is_in_group("player"):
		$CuttingArea/CuttingIcon.play("normal")
		in_cutting = false
func _on_stove_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and PlayerVariables.pantry_completed and PlayerVariables.cutting_completed and PlayerVariables.mixing_completed  and not PlayerVariables.stove_completed:
		$StoveArea/StoveText.show()
		$StoveArea/StoveIcon.play("hover")
		in_stove = true
func _on_stove_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		$StoveArea/StoveText.hide()
		$StoveArea/StoveIcon.play("normal")
		in_stove = false
func _on_mixing_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and PlayerVariables.pantry_completed and PlayerVariables.cutting_completed  and not PlayerVariables.mixing_completed:
		$MixingArea/MixingText.show()
		$MixingArea/MixingIcon.play("hover")
		in_mixing = true
func _on_mixing_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		$MixingArea/MixingText.hide()
		$MixingArea/MixingIcon.play("normal")
		in_mixing = false
func _on_plating_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and PlayerVariables.pantry_completed and PlayerVariables.cutting_completed and PlayerVariables.mixing_completed and PlayerVariables.stove_completed and not PlayerVariables.plating_completed:
		$PlatingArea/PlatingText.show()
		$PlatingArea/PlatingIcon.play("hover")
		in_plating = true
func _on_plating_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		$PlatingArea/PlatingText.hide()
		$PlatingArea/PlatingIcon.play("normal")
		in_plating = false
