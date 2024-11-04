extends Node2D
@onready var ReferencePic = $ReferencePic
@onready var bowl_sprites=$BowlsContainer
@onready var Timer1 = $Timer1

var peas_dragging = false;
var cheese1_dragging = false;
var cheese2_dragging = false;
var cheese3_dragging = false;
var bacon1_dragging = false;
var bacon2_dragging = false;
var bacon3_dragging = false;


var peas_correct = false;
var cheese1_correct = false;
var cheese2_correct = false;
var cheese3_correct = false;
var bacon1_correct = false;
var bacon2_correct = false;
var bacon3_correct = false;

var mouse_offset = Vector3.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	ReferencePic.visible= true
	bowl_sprites.visible= false
	Timer1.wait_time= 3.0
	Timer1.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if peas_dragging:
		$BowlsContainer/BlueBowl/Peas.global_position = get_global_mouse_position() + mouse_offset
	if cheese1_dragging:
		$BowlsContainer/PinkBowl/Cheese1.global_position = get_global_mouse_position() + mouse_offset
	if cheese2_dragging:
		$BowlsContainer/PinkBowl/Cheese2.global_position = get_global_mouse_position() + mouse_offset
	if cheese3_dragging:
		$BowlsContainer/PinkBowl/Cheese3.global_position = get_global_mouse_position() + mouse_offset
	if bacon1_dragging:
		$BowlsContainer/YellowPlate/Bacon1.global_position = get_global_mouse_position() + mouse_offset
	if bacon2_dragging:
		$BowlsContainer/YellowPlate/Bacon2.global_position = get_global_mouse_position() + mouse_offset
	if bacon3_dragging:
		$BowlsContainer/YellowPlate/Bacon3.global_position = get_global_mouse_position() + mouse_offset

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.

func _on_taste_test_button_pressed()-> void:
	get_tree().change_scene_to_file("res://taste_test.tscn")
	


func _on_timer_1_timeout() -> void:
	ReferencePic.visible= false
	bowl_sprites.visible= true


# check if peas are currently being pressed down
func _on_pea_button_button_down() -> void:
	peas_dragging = true;
	mouse_offset = $BowlsContainer/BlueBowl/Peas.global_position - get_global_mouse_position()

# check if peas have been released
func _on_pea_button_button_up() -> void:
	peas_dragging = false;


# check if cheese 1 is currently being pressed down
func _on_cheese_1_button_button_down() -> void:
	cheese1_dragging = true;
	mouse_offset = $BowlsContainer/PinkBowl/Cheese1.global_position - get_global_mouse_position()

# check if cheese 1 has been released
func _on_cheese_1_button_button_up() -> void:
	cheese1_dragging = false;

# check if cheese 2 is currently being pressed down
func _on_cheese_2_button_button_down() -> void:
	cheese2_dragging = true;
	mouse_offset = $BowlsContainer/PinkBowl/Cheese2.global_position - get_global_mouse_position()

# check if cheese 2 has been released
func _on_cheese_2_button_button_up() -> void:
	cheese2_dragging = false;

# check if cheese 3 has been released
func _on_cheese_3_button_button_down() -> void:
	cheese3_dragging = true;
	mouse_offset = $BowlsContainer/PinkBowl/Cheese3.global_position - get_global_mouse_position()

# check if cheese 3 has been released
func _on_cheese_3_button_button_up() -> void:
	cheese3_dragging = false;
	
func _on_bacon_1_button_button_down() -> void:
	bacon1_dragging = true;
	mouse_offset = $BowlsContainer/YellowPlate/Bacon1.global_position - get_global_mouse_position()


func _on_bacon_1_button_button_up() -> void:
	bacon1_dragging = false;


func _on_bacon_2_button_button_down() -> void:
	bacon2_dragging = true;
	mouse_offset = $BowlsContainer/YellowPlate/Bacon2.global_position - get_global_mouse_position()


func _on_bacon_2_button_button_up() -> void:
	bacon2_dragging = false;

func _on_bacon_3_button_button_down() -> void:
	bacon3_dragging = true;
	mouse_offset = $BowlsContainer/YellowPlate/Bacon3.global_position - get_global_mouse_position()


func _on_bacon_3_button_button_up() -> void:
	bacon3_dragging = false;
	


# checks when center of peas has entered pea target area
func _on_pea_target_area_entered(area: Area2D) -> void:
	if area.is_in_group("peas"):
		print("peas are in correct location!")
		peas_correct = true;

# checks when center of peas has exited pea target area
func _on_pea_target_area_exited(area: Area2D) -> void:
	if area.is_in_group("peas"):
		print("peas are no longer in correct location!")
		peas_correct = false;


# checks when center of a cheese has entered cheese target area 1
func _on_cheese_target_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 1 is in correct location!")
		cheese1_correct = true;

# checks when center of a cheese has exited cheese target area 1
func _on_cheese_target_1_area_exited(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 1 is no longer in correct location!")
		cheese1_correct = false;


# checks when center of a cheese has entered cheese target area 2
func _on_cheese_target_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 2 is in correct location!")
		cheese2_correct = true;

# checks when center of a cheese has exited cheese target area 2
func _on_cheese_target_2_area_exited(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 2 is no longer in correct location!")
		cheese2_correct = false;
		
		
# checks when center of a cheese has entered cheese target area 3
func _on_cheese_target_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 3 is in correct location!")
		cheese3_correct = true;

# checks when center of a cheese has exited cheese target area 3
func _on_cheese_target_3_area_exited(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 3 is no longer in correct location!")
		cheese3_correct = false;


# checks when center of a piece of bacon has entered bacon target area 1
func _on_bacon_target_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 1 is in correct location!")
		bacon1_correct = true;

# checks when center of a piece of bacon has exited bacon target area 1
func _on_bacon_target_1_area_exited(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 1 is no longer in correct location!")
		bacon1_correct = false;


# checks when center of a piece of bacon has entered bacon target area 2
func _on_bacon_target_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 2 is in correct location!")
		bacon2_correct = true;

# checks when center of a piece of bacon has exited bacon target area 2
func _on_bacon_target_2_area_exited(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 2 is no longer in correct location!")
		bacon2_correct = false;


# checks when center of a piece of bacon has entered bacon target area 3
func _on_bacon_target_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 3 is in correct location!")
		bacon3_correct = true;

# checks when center of a piece of bacon has exited bacon target area 3
func _on_bacon_target_3_area_exited(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 3 is no longer in correct location!")
		bacon3_correct = false;
