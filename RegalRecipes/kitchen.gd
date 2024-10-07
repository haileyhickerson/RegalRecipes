extends Node2D
var in_pantry = false
var in_cutting = false
var in_stove = false
var in_mixing = false
var in_plating = false
var in_exit = false

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	if Input.is_action_pressed("action") and in_pantry:
		get_tree().change_scene_to_file("res://pantry.tscn") 
	if Input.is_action_pressed("action") and in_cutting:
		get_tree().change_scene_to_file("res://cutting.tscn") 
	if Input.is_action_pressed("action") and in_mixing:
		get_tree().change_scene_to_file("res://mixing.tscn") 
	if Input.is_action_pressed("action") and in_stove:
		get_tree().change_scene_to_file("res://stove.tscn") 
	if Input.is_action_pressed("action") and in_plating:
		get_tree().change_scene_to_file("res://plating.tscn") 
	if Input.is_action_pressed("action") and in_exit:
		get_tree().quit()

func _on_pantry_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_pantry = true
func _on_pantry_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_pantry = false
func _on_cutting_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_cutting = true 
func _on_cutting_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_cutting = false
func _on_stove_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_stove = true
func _on_stove_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_stove = false
func _on_mixing_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_mixing = true
func _on_mixing_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_mixing = false
func _on_plating_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_plating = true
func _on_plating_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_plating = false
func _on_exit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_exit = true
func _on_exit_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		in_exit = false
