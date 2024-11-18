extends Sprite2D

@export var oven_script: Node
# Target rotation for the correct temperature (e.g., 90 degrees)
var target_rotation = 0
# Speed of rotation in degrees per second
var rotation_speed = 250
# Track if the temperature was set correctly
var can_click = false
var knob1_completed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees += rotation_speed * delta
	rotation_degrees = fmod(rotation_degrees, 360) 
	if !knob1_completed:
		rotation_speed = 250
	else:
		rotation_speed = 0
	
func _input(event):
	# Check if the player clicked the mouse
	if event.is_action_pressed("click") and can_click:
		# Check if the click happened on the knob's area
		if get_rect().has_point(to_local(event.position)):
			check_temperature()

func check_temperature():
	# Check if the current rotation is within the target range
	var current_rotation = rotation_degrees
	var temp_difference = 360 - current_rotation
	print(current_rotation, temp_difference)
	
	if current_rotation <= 10 or temp_difference <= 10:
		oven_script.butterspoon_good()
	else:
		oven_script.butterspoon_bad()
