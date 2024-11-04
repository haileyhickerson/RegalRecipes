extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered", Callable(self, "_on_TargetPeas_area_entered"))
	print("connected")

func _on_TargetPeas_area_entered(area):
	if area.name== "Peas":
		#Checkmark.visible = true
		#Checkmark_timer.start()
		print("correct plating") # Stop dragging when placed in the correct spot

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
