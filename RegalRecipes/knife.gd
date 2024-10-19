extends Area2D
@export var direction = 1 
@export var speed = 300
# Reference to the cutting script
@onready var cutting_script = get_parent()
# Knife dimensions
var margin_of_error = 10  # How close knife needs to be to make a cut

func _input(event):
	if event.is_action_pressed("action") or event is InputEventMouseButton and event.pressed:
		emit_signal("attempt_cut")


func _process(delta):
	# Move knife left and right
	position.x += speed * delta * direction
	# Reverse direction when reaching screen edges
	if position.x <= 0:
		direction = 1  # Move right
	elif position.x >= get_viewport_rect().size.x:
		direction = -1  # Move left

func check_for_cut():
	 #Use the cutting script to detect if a cut is successful
	var cut_line = cutting_script.get_nearest_cut_line(position.x)
	print("positions"+str(position.x),str(cut_line))
	if abs(position.x - cut_line) <= margin_of_error:
		 #If the knife is near a cut line, make the cut
		cutting_script.make_cut(cut_line)
		print("positions"+str(position.x),str(cut_line))
	else:
		print("not cutting")
		



#var screen_size
#var start_position = Vector2(300, 300)
#
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#screen_size = get_viewport_rect().size
#
#func _process(delta: float) -> void:
	#var mouse_position = get_viewport().get_mouse_position()
	#position = mouse_position
	#position = position.clamp(Vector2.ZERO, screen_size)
