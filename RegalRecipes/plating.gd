extends Node2D
@onready var ReferencePic = $ReferencePic
@onready var bowl_sprites=$BowlsContainer
@onready var Timer1 = $Timer1


# Called when the node enters the scene tree for the first time.
func _ready():
	ReferencePic.visible= true
	bowl_sprites.visible= false
	Timer1.wait_time= 3.0
	Timer1.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.

func _on_taste_test_button_pressed()-> void:
	get_tree().change_scene_to_file("res://taste_test.tscn")
	


func _on_timer_1_timeout() -> void:
	ReferencePic.visible= false
	bowl_sprites.visible= true
	
