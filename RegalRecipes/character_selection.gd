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
