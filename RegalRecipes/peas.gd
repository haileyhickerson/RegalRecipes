extends Area2D
var is_dragging = false
var is_mouse_over= false
var mouse_offset = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CollisionShape2D.disabled = false
	set_process_input(true)
	self.connect("input_event", Callable(self, "_on_input_event"))

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Check if the mouse click is inside the CollisionShape2D
			is_dragging = true
			mouse_offset = global_position- event.position
		else:
			is_dragging = false

func _process(delta):
	# If dragging, follow the mouse
	if is_dragging:
		global_position= get_global_mouse_position() +mouse_offset





#func _on_input_event(viewport, event, shape_idx):
	#if event is InputEventMouseButton:
		#print("Mouse button event detected")
		#if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			#is_dragging = true
			#
			#print("left button pressed")
		#elif not event.pressed and event.button_index== MOUSE_BUTTON_LEFT:
			#print("left button released")
			#is_dragging= false
			##check_drop()
	#if event is InputEventMouseMotion and is_dragging:
		#position += get_global_mouse_position()-(self.scale*self.texture.get_size()/2)
#func _on_Area2D_input_event(viewport,event, shape_idx):
	#if event is InputEventMouseMotion:
		#is_mouse_over= true
	#elif event is InputEventMouseButton:
		#if not event.presed:
			#is_mouse_over= false

#func check_drop():
	## Check if the ingredient is dropped on a valid spot
	#var plate = get_parent().get_parent().get_parent()  # Adjust to get the Plate node
	#for spot in plate.get_children():
		#if spot.is_in_group("plate_spots") and spot.get_global_transform().origin.has_point(get_global_mouse_position()):
			#position = spot.position  # Snap the area to the spot
			#print("Dropped on " + spot.name)
			#return
