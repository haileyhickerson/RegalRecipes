extends Node2D
@onready var ReferencePic = $ReferencePic
@onready var bowl_sprites=$BowlsContainer
@onready var Timer1 = $Timer1
@onready var TextBox= $TextBox
@onready var StartButton= $StartButton
@onready var ScoreTextBox =$ScoreTextBox
@onready var ScoringLabel =$ScoreTextBox/Scoring


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

var score=0

# Called when the node enters the scene tree for the first time.
func _ready():
	ReferencePic.visible= true
	$HintReferencePic.visible=false
	bowl_sprites.visible= false
	$HintButton.hide()
	#Timer1.wait_time= 3.0
	#Timer1.start()
	ScoreTextBox.visible= false
	$FancyCircle.visible=false
	$ButterspoonHead.visible= false
	$HintText.visible=false
	$ContinueButton.hide()
	
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

func update_score_label():
	if score<0:
		score=0
	ScoringLabel.text= "Final Score: "+ str(score)
	
func add_score(points):
	score+= points

func subtract_score(points):
	score -= points


func _on_taste_test_button_pressed()-> void:
	$"Taste Test Button".hide()
	update_score_label()
	PlayerVariables.plating_score= score
	ScoreTextBox.visible= true
	print("Plating complete! Final Score: ", score)
	PlayerVariables.plating_completed=true
	$ContinueButton.show()



	
	



func _on_timer_1_timeout() -> void:
	ReferencePic.visible= false
	bowl_sprites.visible= true
	$FancyCircle.visible=true
	$ButterspoonHead.visible= true
	$HintText.visible=true
	$HintButton.show()


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
		add_score(10)
		

# checks when center of peas has exited pea target area
func _on_pea_target_area_exited(area: Area2D) -> void:
	if area.is_in_group("peas"):
		print("peas are no longer in correct location!")
		peas_correct = false;
		subtract_score(10)

# checks when center of a cheese has entered cheese target area 1
func _on_cheese_target_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 1 is in correct location!")
		cheese1_correct = true;
		add_score(15)

# checks when center of a cheese has exited cheese target area 1
func _on_cheese_target_1_area_exited(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 1 is no longer in correct location!")
		cheese1_correct = false;
		subtract_score(15)


# checks when center of a cheese has entered cheese target area 2
func _on_cheese_target_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 2 is in correct location!")
		cheese2_correct = true;
		add_score(15)

# checks when center of a cheese has exited cheese target area 2
func _on_cheese_target_2_area_exited(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 2 is no longer in correct location!")
		cheese2_correct = false;
		subtract_score(15)

		
# checks when center of a cheese has entered cheese target area 3
func _on_cheese_target_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 3 is in correct location!")
		cheese3_correct = true;
		add_score(15)

# checks when center of a cheese has exited cheese target area 3
func _on_cheese_target_3_area_exited(area: Area2D) -> void:
	if area.is_in_group("cheese"):
		print("cheese 3 is no longer in correct location!")
		cheese3_correct = false;
		subtract_score(15)


# checks when center of a piece of bacon has entered bacon target area 1
func _on_bacon_target_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 1 is in correct location!")
		bacon1_correct = true;
		add_score(15)

# checks when center of a piece of bacon has exited bacon target area 1
func _on_bacon_target_1_area_exited(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 1 is no longer in correct location!")
		bacon1_correct = false;
		subtract_score(15)


# checks when center of a piece of bacon has entered bacon target area 2
func _on_bacon_target_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 2 is in correct location!")
		bacon2_correct = true;
		add_score(15)

# checks when center of a piece of bacon has exited bacon target area 2
func _on_bacon_target_2_area_exited(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 2 is no longer in correct location!")
		bacon2_correct = false;
		subtract_score(15)


# checks when center of a piece of bacon has entered bacon target area 3
func _on_bacon_target_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 3 is in correct location!")
		bacon3_correct = true;
		add_score(15)

# checks when center of a piece of bacon has exited bacon target area 3
func _on_bacon_target_3_area_exited(area: Area2D) -> void:
	if area.is_in_group("bacon"):
		print("bacon 3 is no longer in correct location!")
		bacon3_correct = false;
		subtract_score(15)


func _on_start_button_pressed() -> void:
	StartButton.hide()
	TextBox.visible= false
	Timer1.wait_time= 3.0
	Timer1.start()


func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://taste_test.tscn")


func _on_hint_button_pressed() -> void:
	$HintButton.hide()
	$FancyCircle.visible=false
	$ButterspoonHead.visible= false
	$HintText.visible=false
	$HintReferencePic.visible= true
	$HintTimer.wait_time= 1.0
	$HintTimer.start()
	subtract_score(10)
	

func _on_hint_timer_timeout() -> void:
	$HintReferencePic.visible= false
	$HintButton.show()
	
