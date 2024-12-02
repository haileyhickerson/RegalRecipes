extends Area2D
@export var direction = 1 
@export var speed = 450
var min_x= 352
var max_x= 1650
# Reference to the cutting script


func _process(delta):
	position.x += speed * delta * direction
	position.x = clamp(position.x, min_x, max_x)
	# reverse direction when reaching end of board
	if position.x == min_x:
		direction = 1  # move right
	elif position.x == max_x:
		direction = -1  
