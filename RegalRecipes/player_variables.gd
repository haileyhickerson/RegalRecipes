extends Node

var location

var first_move = false;

var pantry_completed = false;
var cutting_completed = false;
var mixing_completed = false;
var stove_completed = false;
var plating_completed = false;

var plating_score

var chef_selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	location = Vector2(400, 400)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
