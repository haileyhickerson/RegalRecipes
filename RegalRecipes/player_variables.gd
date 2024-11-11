extends Node

var location

var first_move = false
var intro_completed = false
var recipe1_completed = true
var recipe2_completed = false
var curr_recipe = 0
var correct_ingredients = [["Bacon1", "Bacon2", "Bacon3", "Peas", "Cheese", "Dressing"], ["Carrot1", "Carrot2", "Carrot3", "Steak", "Garlic", "Onion", "Potato", "Butter", "SteakSauce"], ["Recipe3Ingredients"]]

var pantry_completed = false
var cutting_completed = false
var mixing_completed = false
var stove_completed = false
var plating_completed = false

var pantry_score = 0
var cutting_score = 0
var mixing_score = 0
var stove_score = 0
var plating_score = 0

var final_score = 0

var chef_selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	location = Vector2(400, 400)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	final_score = pantry_score + cutting_score + mixing_score + stove_score + plating_score
