extends Node2D

var correct_ingredients = ["Ingredient1", "Ingredient2", "Ingredient3"]
var selected_ingredients = []
var stopwatch_time = 0.0
var stopwatch_started = true
var is_dragging = false
var mouse_offset
var delay = 10
var original_position = Vector2.ZERO
var curr_ingredient

@onready var timer = $Timer
@onready var stopwatch_label = $StopwatchDisplay
@onready var basket = $Basket
@onready var popup = $Popup

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	if is_dragging:
		var tween = get_tree().create_tween()
		tween.tween_property(curr_ingredient, "position", get_global_mouse_position(), delay * delta)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			for ingredient in get_tree().get_nodes_in_group("ingredients"):
				# Check if the mouse position is within the Sprite2D's rectangle
				if ingredient.get_rect().has_point(ingredient.to_local(event.position)):
					print("Clicked on ingredient: ", ingredient.name)
					curr_ingredient = ingredient
					is_dragging = true
		else:
			print("down")
			is_dragging = false

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn")

func _end_game(success):
	if success:
		print("All ingredients selected! Final time: ", str(round(stopwatch_time * 10) / 10), " seconds")
		# Load the next station scene (e.g., cutting_station.tscn)
		get_tree().change_scene("res://scenes/cutting_station.tscn")  # Adjust path to the next station scene
	else:
		print("Game Over!")

func _on_timer_timeout() -> void:
	stopwatch_time += 1
	stopwatch_label.text = str(stopwatch_time)
