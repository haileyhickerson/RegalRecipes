extends Sprite2D

@export var stove_script: Node
# Target rotation for the correct temperature (e.g., 90 degrees)
var target_rotation = 90
# Tolerance for how close the player needs to get (5 degrees)
var rotation_tolerance = 15
# Speed of rotation in degrees per second
var rotation_speed = 200
# Track if the temperature was set correctly
var correct_temp = false

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
	print(abs(current_rotation))
	if abs(current_rotation - target_rotation) <= rotation_tolerance:
		correct_temp = true
		print("Correct temperature!")
	else:
		correct_temp = false
		print("Incorrect temperature.")
	rotation_speed = 0
	emit_signal("temperature_set")
	stove_script.start_cooking()
	
func final_temperature():
	return correct_temp
