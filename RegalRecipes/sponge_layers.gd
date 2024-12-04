extends Area2D

@export var direction = 1 
@export var speed = 300

var min_x= 527
var max_x= 1437
func set_direction_and_speed(new_direction: int, new_speed: int):
	direction = new_direction
	speed = new_speed

func _process(delta):
	position.x += speed * delta * direction
	position.x = clamp(position.x, min_x, max_x)
	# reverse direction when reaching end of board
	if position.x == min_x:
		direction = 1  # move right
	elif position.x == max_x:
		direction = -1  
