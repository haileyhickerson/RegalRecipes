extends Area2D

@onready var Checkmark
@onready var CheckmarkTimer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Checkmark.visible = false
	connect("area_entered", Callable(self, "_on_TargetPeas_area_entered"))
	#connect("timeout", Callable(self, "_on_CheckmarkTimer_timeout"))
	print("connected")

func _on_TargetPeas_area_entered(area):
	if area.name== "Peas":
		#Checkmark.visible = true
		#Checkmark_timer.start()
		print("correct plating") # Stop dragging when placed in the correct spot

#func _on_CheckmarkTimer_timeout() -> void:
	#Checkmark.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
