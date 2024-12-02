extends Node2D
@onready var ReferencePic = $ReferencePic
@onready var bowl_sprites=$PlateContainer
@onready var Timer1 = $Timer1
@onready var TextBox= $TextBox
@onready var ScoreTextBox =$ScoreTextBox
@onready var ScoringLabel =$ScoreTextBox/Scoring


var steak_dragging = false;
var potato_dragging = false;
var butter1_dragging = false;
var butter2_dragging = false;
var carrot1_dragging = false;
var carrot2_dragging = false;
var carrot3_dragging = false;


var steak_correct = false;
var potato_correct = false;
var butter1_correct = false;
var butter2_correct = false;
var carrot1_correct = false;
var carrot2_correct = false;
var carrot3_correct = false;

var mouse_offset = Vector3.ZERO;

var score2=0
var first_space_pressed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	ReferencePic.visible= true
	$HintReferencePic.visible=false
	$PlateContainer.visible= false
	$HintButton.hide()
	#Timer1.wait_time= 3.0
	#Timer1.start()
	ScoreTextBox.visible= false
	$ContinueButton.hide()
	$"Taste Test Button".hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		if !first_space_pressed:
			first_space_pressed = true
			TextBox.visible= false
			Timer1.wait_time= 3.0
			Timer1.start()
			
	
	if steak_dragging:
		$PlateContainer/BluePlate/Steak.global_position = get_global_mouse_position() + mouse_offset
	if potato_dragging:
		$PlateContainer/PurplePlate/Potato.global_position = get_global_mouse_position() + mouse_offset
	if butter1_dragging:
		$PlateContainer/GreenPlate/Butter1.global_position = get_global_mouse_position() + mouse_offset
	if butter2_dragging:
		$PlateContainer/GreenPlate/Butter2.global_position = get_global_mouse_position() + mouse_offset
	if carrot1_dragging:
		$PlateContainer/PinkPlate/Carrot1.global_position = get_global_mouse_position() + mouse_offset
	if carrot2_dragging:
		$PlateContainer/PinkPlate/Carrot2.global_position = get_global_mouse_position() + mouse_offset
	if carrot3_dragging:
		$PlateContainer/PinkPlate/Carrot3.global_position = get_global_mouse_position() + mouse_offset

func update_score_label():
	if score2<0:
		score2=0
	ScoringLabel.text= "Final Score: "+ str(score2)
	
func add_score(points2):
	score2+= points2

func subtract_score(points2):
	score2 -= points2


func _on_taste_test_button_pressed()-> void:
	$"Taste Test Button".hide()
	update_score_label()
	PlayerVariables.plating_score= score2
	ScoreTextBox.visible= true
	print("Plating complete! Final Score: ", score2)
	PlayerVariables.plating_completed=true
	$ContinueButton.show()



func _on_timer_1_timeout() -> void:
	ReferencePic.visible= false
	$"Taste Test Button".show()
	$PlateContainer.visible= true
	$HintButton.show()


# check if peas are currently being pressed down
func _on_steak_button_down() -> void:
	steak_dragging = true;
	mouse_offset = $PlateContainer/BluePlate/Steak.global_position - get_global_mouse_position()

# check if peas have been released
func _on_steak_button_up() -> void:
	steak_dragging = false;

# check if potato is currently being pressed down
func _on_potato_button_down() -> void:
	potato_dragging = true;
	mouse_offset = $PlateContainer/PurplePlate/Potato.global_position - get_global_mouse_position()

# check if potato has been released
func _on_potato_button_up() -> void:
	potato_dragging = false;
	
# check if butter1 is currently being pressed down
func _on_butter_1_button_down() -> void:
	butter1_dragging = true;
	mouse_offset = $PlateContainer/GreenPlate/Butter1.global_position - get_global_mouse_position()

# check if butter1 has been released
func _on_butter_1_button_up() -> void:
	butter1_dragging = false;
	
# check if butter2 has been released
func _on_butter_2_button_down() -> void:
	butter2_dragging = true;
	mouse_offset = $PlateContainer/GreenPlate/Butter2.global_position - get_global_mouse_position()

# check if butter2 has been released
func _on_butter_2_button_up() -> void:
	butter2_dragging = false;
	
func _on_carrot_1_button_down() -> void:
	carrot1_dragging = true;
	mouse_offset = $PlateContainer/PinkPlate/Carrot1.global_position - get_global_mouse_position()


func _on_carrot_1_button_up() -> void:
	carrot1_dragging = false;

func _on_carrot_2_button_down() -> void:
	carrot2_dragging = true;
	mouse_offset = $PlateContainer/PinkPlate/Carrot2.global_position - get_global_mouse_position()


func _on_carrot_2_button_up() -> void:
	carrot2_dragging = false;

func _on_carrot_3_button_down() -> void:
	carrot3_dragging = true;
	mouse_offset = $PlateContainer/PinkPlate/Carrot3.global_position - get_global_mouse_position()


func _on_carrot_3_button_up() -> void:
	carrot3_dragging = false;
	

# checks when center of peas has entered pea target area
func _on_steak_target_area_entered(area: Area2D) -> void:
	if area.is_in_group("steak"):
		print("steak are in correct location!")
		steak_correct = true;
		

# checks when center of peas has exited pea target area
func _on_steak_target_area_exited(area: Area2D) -> void:
	if area.is_in_group("steak"):
		print("steak are no longer in correct location!")
		steak_correct = false;

# checks when center of a cheese has entered cheese target area 1
func _on_potato_target_area_entered(area: Area2D) -> void:
	if area.is_in_group("potato"):
		print("potato is in correct location!")
		potato_correct = true;
		add_score(15)

# checks when center of a cheese has exited cheese target area 1
func _on_potato_target_area_exited(area: Area2D) -> void:
	if area.is_in_group("potato"):
		print("potato is no longer in correct location!")
		potato_correct = false;
		subtract_score(15)

# checks when center of a cheese has entered cheese target area 2
func _on_butter_target_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("butter"):
		print("butter 1 is in correct location!")
		butter1_correct = true;
		add_score(15)

# checks when center of a cheese has exited cheese target area 2
func _on_butter_target_1_area_exited(area: Area2D) -> void:
	if area.is_in_group("butter"):
		print("butter 1 is no longer in correct location!")
		butter1_correct = false;
		subtract_score(15)
		
# checks when center of a cheese has entered cheese target area 3
func _on_butter_target_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("butter"):
		print("butter 2 is in correct location!")
		butter2_correct = true;
		add_score(15)

# checks when center of a cheese has exited cheese target area 3
func _on_butter_target_2_area_exited(area: Area2D) -> void:
	if area.is_in_group("butter"):
		print("butter 2 is no longer in correct location!")
		butter2_correct = false;
		subtract_score(15)


# checks when center of a piece of bacon has entered bacon target area 1
func _on_carrot_target_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("carrot"):
		print("carrot 1 is in correct location!")
		carrot1_correct = true;
		add_score(15)

# checks when center of a piece of bacon has exited bacon target area 1
func _on_carrot_target_1_area_exited(area: Area2D) -> void:
	if area.is_in_group("carrot"):
		print("carrot 1 is no longer in correct location!")
		carrot1_correct = false;
		subtract_score(15)


# checks when center of a piece of bacon has entered bacon target area 2
func _on_carrot_target_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("carrot"):
		print("bacon 2 is in correct location!")
		carrot2_correct = true;
		add_score(15)

# checks when center of a piece of bacon has exited bacon target area 2
func _on_carrot_target_2_area_exited(area: Area2D) -> void:
	if area.is_in_group("carrot"):
		print("carrot 2 is no longer in correct location!")
		carrot2_correct = false;
		subtract_score(15)


# checks when center of a piece of bacon has entered bacon target area 3
func _on_carrot_target_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("carrot"):
		print("carrot 3 is in correct location!")
		carrot3_correct = true;
		add_score(15)

# checks when center of a piece of bacon has exited bacon target area 3
func _on_carrot_target_3_area_exited(area: Area2D) -> void:
	if area.is_in_group("carrot"):
		print("carrot 3 is no longer in correct location!")
		carrot3_correct = false;
		subtract_score(15)
		
		

# checks when center of a cheese has entered cheese target area 2


func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://taste_test.tscn")


func _on_hint_button_pressed() -> void:
	$HintButton.hide()
	$HintReferencePic.visible= true
	$HintTimer.wait_time= 1.0
	$HintTimer.start()
	subtract_score(10)
	

func _on_hint_timer_timeout() -> void:
	$HintReferencePic.visible= false
	$HintButton.show()
	
