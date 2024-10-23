extends Sprite2D

var is_dragging = false
var mouse_offset
var move_speed = Vector2() # Movement speed for random motion
var speed = 200
var directions = [
		Vector2(1, 1),   # Down-Right
		Vector2(1, -1),  # Up-Right
		Vector2(-1, 1),  # Down-Left
		Vector2(-1, -1)  # Up-Left
	]

func _ready():
	# Randomize the initial direction and speed
	move_speed = directions[randi() % directions.size()] * speed

func _physics_process(delta):
	# If dragging, follow the mouse
	if is_dragging:
		self.position = get_global_mouse_position() - mouse_offset
	else:
		# Move the ingredient based on its assigned speed and direction
		position += move_speed * delta
		
		# Keep ingredient within screen bounds
		if position.x < 0 or position.x > get_viewport().size.x:
			move_speed.x *= -1 # Reverse x direction if it hits left/right walls
		if position.y < 0 or position.y > get_viewport().size.y:
			move_speed.y *= -1 # Reverse y direction if it hits top/bottom walls

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				is_dragging = true
				mouse_offset = get_global_mouse_position() - global_position
				move_speed = Vector2.ZERO # Stop random movement when dragging
		else:
			is_dragging = false
			move_speed = directions[randi() % directions.size()] * speed
