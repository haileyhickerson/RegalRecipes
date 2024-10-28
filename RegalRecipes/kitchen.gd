extends Node2D
var in_pantry = false
var in_cutting = false
var in_stove = false
var in_mixing = false
var in_plating = false
var in_exit = false

var first_move = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
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
	if PlayerVariables.location != Vector2(400, 400):
		first_move = true
		
	if first_move:
		await get_tree().create_timer(.5).timeout 
		$MoveText.hide()
		
	if Input.is_action_pressed("action") and in_pantry:
		get_tree().change_scene_to_file("res://pantry.tscn")
		#await get_tree().create_timer(0.1).timeout 
		$PantryArea/PantryIcon.play("press")
	if Input.is_action_pressed("action") and in_cutting:
		$CuttingArea/CuttingIcon.play("press")
		await get_tree().create_timer(0.1).timeout
		get_tree().change_scene_to_file("res://cutting.tscn") 
	if Input.is_action_pressed("action") and in_mixing:
		$MixingArea/MixingIcon.play("press")
		await get_tree().create_timer(0.1).timeout
		get_tree().change_scene_to_file("res://mixing.tscn") 
	if Input.is_action_pressed("action") and in_stove:
		$StoveArea/StoveIcon.play("press")
		await get_tree().create_timer(0.1).timeout
		get_tree().change_scene_to_file("res://stove.tscn") 
	if Input.is_action_pressed("action") and in_plating:
		$PlatingArea/PlatingIcon.play("press")
		await get_tree().create_timer(0.1).timeout
		get_tree().change_scene_to_file("res://plating.tscn") 


func _on_pantry_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$PantryArea/PantryText.show()
		$PantryArea/PantryIcon.play("hover")
		in_pantry = true
func _on_pantry_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		$PantryArea/PantryText.hide()
		$PantryArea/PantryIcon.play("normal")
		in_pantry = false
func _on_cutting_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$CuttingArea/CuttingText.show()
		$CuttingArea/CuttingIcon.play("hover")
		in_cutting = true 
func _on_cutting_area_area_exited(area: Area2D) -> void:
	$CuttingArea/CuttingText.hide()
	if area.is_in_group("player"):
		$CuttingArea/CuttingIcon.play("normal")
		in_cutting = false
func _on_stove_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$StoveArea/StoveText.show()
		$StoveArea/StoveIcon.play("hover")
		in_stove = true
func _on_stove_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		$StoveArea/StoveText.hide()
		$StoveArea/StoveIcon.play("normal")
		in_stove = false
func _on_mixing_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$MixingArea/MixingText.show()
		$MixingArea/MixingIcon.play("hover")
		in_mixing = true
func _on_mixing_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		$MixingArea/MixingText.hide()
		$MixingArea/MixingIcon.play("normal")
		in_mixing = false
func _on_plating_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$PlatingArea/PlatingText.show()
		$PlatingArea/PlatingIcon.play("hover")
		in_plating = true
func _on_plating_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		$PlatingArea/PlatingText.hide()
		$PlatingArea/PlatingIcon.play("normal")
		in_plating = false
