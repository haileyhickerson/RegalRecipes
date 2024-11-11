extends RigidBody2D

# movement vector
@export var move_speed = Vector2()
# boolean denoting if object is being dragged by mouse
@export var dragging = false
# boolean denoting if object is in the basket
@export var in_basket = false
# boolean denoting if object is overlapping the basket
@export var over_basket = false
# vector to track mouse offset
var mouse_offset
# speed of ingredient movement
var speed = randf_range(180,230)

var basket_pos

# array of possible directions of movement
var directions = [
	
		Vector2(1, 1),   # Down-Right
		Vector2(1, -1),  # Up-Right
		Vector2(-1, 1),  # Down-Left
		Vector2(-1, -1)  # Up-Left
	]

func _ready():
	# randomize the initial direction and speed
	randomize_speed()
	# set velocity to random speed
	set_velocity()
	# randomizes position once in basket
	randomize_basket_pos()

func _process(delta: float) -> void:
	# if placed and released in basket
	if in_basket and not dragging:
		# disables clicking it again
		$Button.disabled = true
		$CollisionShape2D.disabled = true
		position = basket_pos

# randomizes speed vector
func randomize_speed():
	move_speed = directions[randi() % directions.size()] * speed

# sets velocity to move speed
func set_velocity():
	set_linear_velocity(move_speed)

func randomize_basket_pos():
	basket_pos = Vector2(randf_range(1580, 1820), randf_range(780, 1020))
