extends Sprite2D

@export var stove_script: Node
# Target rotation for the correct temperature (e.g., 90 degrees)
var target_rotation = 90
# Speed of rotation in degrees per second
var rotation_speed = 200
# Track if the temperature was set correctly
var temp_score

func _process(delta):
	# Rotate the knob continuously
	rotation_degrees += rotation_speed * delta
	rotation_degrees = fmod(rotation_degrees, 360)  # Keep the rotation within 0-359

func _input(event):
	# Check if the player clicked the mouse
	if event.is_action_pressed("click"):
		# Check if the click happened on the knob's area
		if get_rect().has_point(to_local(event.position)):
			check_temperature()

func check_temperature():
	# Check if the current rotation is within the target range
	var current_rotation = rotation_degrees
	var temp_difference = abs(current_rotation - target_rotation)
	print(abs(current_rotation))
	
	if temp_difference <= 10:
		temp_score = 50
	elif temp_difference <= 20:
		temp_score = 30
	elif temp_difference <= 30:
		temp_score = 20
	else:
		temp_score = 0
	print(temp_score)
	rotation_speed = 0
	stove_script.start_cooking()
	
func get_score():
	return temp_score
