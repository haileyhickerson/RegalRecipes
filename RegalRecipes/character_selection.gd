extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_chef_1_pressed() -> void:
	PlayerVariables.chef_selected = 1
	get_tree().change_scene_to_file("res://recipe_selection.tscn")


func _on_chef_2_pressed() -> void:
	PlayerVariables.chef_selected = 2
	get_tree().change_scene_to_file("res://recipe_selection.tscn")


func _on_chef_3_pressed() -> void:
	PlayerVariables.chef_selected = 3
	get_tree().change_scene_to_file("res://recipe_selection.tscn")


func _on_chef_4_pressed() -> void:
	PlayerVariables.chef_selected = 4
	get_tree().change_scene_to_file("res://recipe_selection.tscn")


func _on_female_chef_1_pressed() -> void:
	PlayerVariables.chef_selected = 5
	get_tree().change_scene_to_file("res://recipe_selection.tscn")


func _on_female_chef_2_pressed() -> void:
	PlayerVariables.chef_selected = 6
	get_tree().change_scene_to_file("res://recipe_selection.tscn")


func _on_female_chef_3_pressed() -> void:
	PlayerVariables.chef_selected = 7
	get_tree().change_scene_to_file("res://recipe_selection.tscn")


func _on_female_chef_4_pressed() -> void:
	PlayerVariables.chef_selected = 8
	get_tree().change_scene_to_file("res://recipe_selection.tscn")
