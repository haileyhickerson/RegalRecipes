extends Area2D

@export var direction = 1 
@export var speed = 300

func set_direction_and_speed(new_direction: int, new_speed: int):
	direction = new_direction
	speed = new_speed

func _process(delta):
	# Move knife left and right
	position.x += speed * delta * direction
	# Reverse direction when reaching screen edges
	if position.x <= 0:
		direction = 1  # Move right
	elif position.x >= get_viewport_rect().size.x:
		direction = -1  # Move left
