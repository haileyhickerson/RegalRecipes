extends Node2D
@onready var ReferencePic = $ReferencePic
@onready var bowl_sprites=$PlateContainer
@onready var Timer1 = $Timer1
@onready var TextBox= $TextBox
@onready var ScoreTextBox =$ScoreTextBox
@onready var ScoringLabel =$ScoreTextBox/Scoring


var whipped1_dragging = false;
var whipped2_dragging = false;
var whipped3_dragging = false;
var whipped4_dragging = false;
var whipped5_dragging = false;

var rasberry1_dragging = false
var rasberry2_dragging = false
var rasberry3_dragging = false
var rasberry4_dragging = false
var rasberry5_dragging = false

var whipped1_correct = false;
var whipped2_correct = false;
var whipped3_correct = false;
var whipped4_correct = false;
var whipped5_correct = false;
var rasberry1_correct = false;
var rasberry2_correct = false;
var rasberry3_correct = false;
var rasberry4_correct = false;
var rasberry5_correct = false;

var mouse_offset = Vector3.ZERO;

var score3=0
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
			
	
	if whipped1_dragging:
		$PlateContainer/BluePlate/Whipped1.global_position = get_global_mouse_position() + mouse_offset
	if whipped2_dragging:
		$PlateContainer/BluePlate/Whipped2.global_position = get_global_mouse_position() + mouse_offset
	if whipped3_dragging:
		$PlateContainer/BluePlate/Whipped3.global_position = get_global_mouse_position() + mouse_offset
	if whipped4_dragging:
		$PlateContainer/BluePlate/Whipped4.global_position = get_global_mouse_position() + mouse_offset
	if whipped5_dragging:
		$PlateContainer/BluePlate/Whipped5.global_position = get_global_mouse_position() + mouse_offset
	if rasberry1_dragging:
		$PlateContainer/PurplePlate/Rasberry1.global_position = get_global_mouse_position() + mouse_offset
	if rasberry2_dragging:
		$PlateContainer/PurplePlate/Rasberry2.global_position = get_global_mouse_position() + mouse_offset
	if rasberry3_dragging:
		$PlateContainer/PurplePlate/Rasberry3.global_position = get_global_mouse_position() + mouse_offset
	if rasberry4_dragging:
		$PlateContainer/PurplePlate/Rasberry4.global_position = get_global_mouse_position() + mouse_offset
	if rasberry5_dragging:
		$PlateContainer/PurplePlate/Rasberry5.global_position = get_global_mouse_position() + mouse_offset

func update_score_label():
	if score3<0:
		score3=0
	ScoringLabel.text= "Final Score: "+ str(score3) + "/100"
	
func add_score(points2):
	score3+= points2

func subtract_score(points2):
	score3 -= points2


func _on_taste_test_button_pressed()-> void:
	$"Taste Test Button".hide()
	update_score_label()
	PlayerVariables.plating_score= score3
	ScoreTextBox.visible= true
	print("Plating complete! Final Score: ", score3)
	PlayerVariables.plating_completed=true
	$ContinueButton.show()



func _on_timer_1_timeout() -> void:
	ReferencePic.visible= false
	if !PlayerVariables.plating_completed:
		$"Taste Test Button".show()
	$PlateContainer.visible= true
	$HintButton.show()


# check if peas are currently being pressed down
func _on_whipped1_button_down() -> void:
	whipped1_dragging = true;
	mouse_offset = $PlateContainer/BluePlate/Whipped1.global_position - get_global_mouse_position()

# check if peas have been released
func _on_whipped1_button_up() -> void:
	whipped1_dragging = false;
	$PlopSound.play()

# check if potato is currently being pressed down
func _on_whipped2_button_down() -> void:
	whipped2_dragging = true;
	mouse_offset = $PlateContainer/BluePlate/Whipped2.global_position - get_global_mouse_position()

# check if potato has been released
func _on_whipped2_button_up() -> void:
	whipped2_dragging = false;
	$PlopSound.play()
	
# check if butter1 is currently being pressed down
func _on_whipped3_button_down() -> void:
	whipped3_dragging = true;
	mouse_offset = $PlateContainer/BluePlate/Whipped3.global_position - get_global_mouse_position()

# check if butter1 has been released
func _on_whipped3_button_up() -> void:
	whipped3_dragging = false;
	$PlopSound.play()
	
# check if butter2 has been released
func _on_whipped4_button_down() -> void:
	whipped4_dragging = true;
	mouse_offset = $PlateContainer/BluePlate/Whipped4.global_position - get_global_mouse_position()

# check if butter2 has been released
func _on_whipped4_button_up() -> void:
	whipped4_dragging = false;
	$PlopSound.play()
	
func _on_whipped5_button_down() -> void:
	whipped5_dragging = true;
	mouse_offset = $PlateContainer/BluePlate/Whipped5.global_position - get_global_mouse_position()


func _on_whipped5_button_up() -> void:
	whipped5_dragging = false;
	$PlopSound.play()

func _on_rasberry1_button_down() -> void:
	rasberry1_dragging = true;
	mouse_offset = $PlateContainer/PurplePlate/Rasberry1.global_position - get_global_mouse_position()


func _on_rasberry1_button_up() -> void:
	rasberry1_dragging = false;
	$PlopSound.play()

func _on_rasberry2_button_down() -> void:
	rasberry2_dragging = true;
	mouse_offset = $PlateContainer/PurplePlate/Rasberry2.global_position - get_global_mouse_position()


func _on_rasberry2_button_up() -> void:
	rasberry2_dragging = false;
	$PlopSound.play()
	
func _on_rasberry3_button_down() -> void:
	rasberry3_dragging = true
	mouse_offset= $PlateContainer/PurplePlate/Rasberry3.global_position- get_global_mouse_position()
	
func _on_rasberry3_button_up() -> void:
	rasberry3_dragging = false
	$PlopSound.play()

func _on_rasberry4_button_down() -> void:
	rasberry4_dragging = true
	mouse_offset= $PlateContainer/PurplePlate/Rasberry4.global_position- get_global_mouse_position()
	
func _on_rasberry4_button_up() -> void:
	rasberry4_dragging = false
	$PlopSound.play()

func _on_rasberry5_button_down() -> void:
	rasberry5_dragging = true
	mouse_offset= $PlateContainer/PurplePlate/Rasberry5.global_position- get_global_mouse_position()
	
func _on_rasberry5_button_up() -> void:
	rasberry5_dragging = false
	$PlopSound.play()

# checks when center of peas has entered pea target area
func _on_berry1_target_area_entered(area: Area2D) -> void:
	if area.is_in_group("rasberries"):
		print("rasberry is in correct location!")
		rasberry1_correct = true;
		add_score(10)
		

# checks when center of peas has exited pea target area
func _on_berry1_target_area_exited(area: Area2D) -> void:
	if area.is_in_group("rasberries"):
		print("rasberry is no longer in correct location!")
		rasberry1_correct = false;
		subtract_score(10)

# checks when center of a cheese has entered cheese target area 1
func _on_berry2_target_area_entered(area: Area2D) -> void:
	if area.is_in_group("rasberries"):
		print("rasberry is in correct location!")
		rasberry2_correct = true;
		add_score(10)

# checks when center of a cheese has exited cheese target area 1
func _on_berry2_target_area_exited(area: Area2D) -> void:
	if area.is_in_group("rasberries"):
		print("rasberry is no longer in correct location!")
		rasberry2_correct = false;
		subtract_score(10)

func _on_berry3_target_area_entered(area: Area2D) -> void:
	if area.is_in_group("rasberries"):
		print("rasberry is in correct location!")
		rasberry3_correct = true;
		add_score(10)

# checks when center of a cheese has exited cheese target area 1
func _on_berry3_target_area_exited(area: Area2D) -> void:
	if area.is_in_group("rasberries"):
		print("rasberry is no longer in correct location!")
		rasberry3_correct = false;
		subtract_score(10)

func _on_berry4_target_area_entered(area: Area2D) -> void:
	if area.is_in_group("rasberries"):
		print("rasberry is in correct location!")
		rasberry4_correct = true;
		add_score(10)

# checks when center of a cheese has exited cheese target area 1
func _on_berry4_target_area_exited(area: Area2D) -> void:
	if area.is_in_group("rasberries"):
		print("rasberry is no longer in correct location!")
		rasberry4_correct = false;
		subtract_score(10)

func _on_berry5_target_area_entered(area: Area2D) -> void:
	if area.is_in_group("rasberries"):
		print("rasberry is in correct location!")
		rasberry5_correct = true;
		add_score(10)

# checks when center of a cheese has exited cheese target area 1
func _on_berry5_target_area_exited(area: Area2D) -> void:
	if area.is_in_group("rasberries"):
		print("rasberry is no longer in correct location!")
		rasberry5_correct = false;
		subtract_score(10)	

func _on_whipped_target_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("swirls"):
		print("swirl is in correct location!")
		whipped1_correct = true;
		add_score(10)


func _on_whipped_target_1_area_exited(area: Area2D) -> void:
	if area.is_in_group("swirls"):
		print("swirl is no longer in correct location!")
		whipped1_correct = false;
		subtract_score(10)	
		
		

func _on_whipped_target_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("swirls"):
		print("swirl is in correct location!")
		whipped2_correct = true;
		add_score(10)

func _on_whipped_target_2_area_exited(area: Area2D) -> void:
	if area.is_in_group("swirls"):
		print("swirl is no longer in correct location!")
		whipped2_correct = false;
		subtract_score(10)	
	

func _on_whipped_target_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("swirls"):
		print("swirl is in correct location!")
		whipped3_correct = true;
		add_score(10)

func _on_whipped_target_3_area_exited(area: Area2D) -> void:
	if area.is_in_group("swirls"):
		print("swirl is in correct location!")
		whipped3_correct = true;
		subtract_score(10)
		

func _on_whipped_target_4_area_entered(area: Area2D) -> void:
	if area.is_in_group("swirls"):
		print("swirl is in correct location!")
		whipped4_correct = true;
		add_score(10)
	

func _on_whipped_target_4_area_exited(area: Area2D) -> void:
	if area.is_in_group("swirls"):
		print("swirl is in correct location!")
		whipped4_correct = true;
		subtract_score(10)


func _on_whipped_target_5_area_entered(area: Area2D) -> void:
	if area.is_in_group("swirls"):
		print("swirl is in correct location!")
		whipped5_correct = true;
		add_score(10)
		
func _on_whipped_target_5_area_exited(area: Area2D) -> void:
	if area.is_in_group("swirls"):
		print("swirl is in correct location!")
		whipped5_correct = true;
		subtract_score(10)
		
		

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
	
