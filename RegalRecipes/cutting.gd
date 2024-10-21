extends Node2D

@export var Cut1: Line2D
@export var Cut2: Line2D
@export var Cut3: Line2D
@export var Score_Label: Label
@export var knife: Area2D
@export var KnifeTip: Marker2D
@export var Cutting_Timer: Timer

# Array of ideal points along line at which cuts should be made
var ideal_cut_points = []
# Score variable
var score = 0
var total_possible_points = 0
var total_cuts = 0
var cut_threshold = 50
# Ready function
func _ready() -> void:
	$NextButton.hide()

	for child in get_children():
		if child is Line2D:
			var points = child.points
			for point in points:
				ideal_cut_points.append(point.x)
	
			
func make_cut(cut_line):
	print("making cut")
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if total_cuts < 3:
			total_cuts += 1
			##use marker2d position for knife
			var knife_position_x= $Knife/KnifeTip.global_position.x
			print("knife:",knife_position_x)
			if check_cut(knife_position_x):
				var points_gained= calculate_score(knife_position_x)
				score += points_gained
				total_possible_points += 100
				print("cut is made")
				update_score_display()
			else:
				print("no cut is made")
				total_possible_points += 100
				update_score_display()
	
		if total_cuts==3:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				update_score_display()
				$NextButton.show()
		#else:
			#get_tree().change_scene_to_file("res://kitchen.tscn")

func check_cut(knife_position_x):
	var cut_made = false
	for cut_point in ideal_cut_points:
		#print("cutx:",cut_point)
		if abs(knife_position_x - cut_point) <= cut_threshold:
			print("Successful cut at position:", knife_position_x,"and cut point", cut_point)
			#play_cutting_sound()
			cut_made= true
			break
		else:
			print("no cut made, not close enough",cut_point)
	return cut_made
		

func calculate_score(knife_position_x):
	var point_distances =[]
	for cut_x in ideal_cut_points:
		point_distances.append(check_cut_accuracy(knife_position_x, cut_x))
	var closest_distance= point_distances.min()
	var points= 100 -int(closest_distance)
	if score<0:
		score=0
	return points
	
func check_cut_accuracy(knife_position_x, cut_x):
	return abs(knife_position_x - cut_x)

func show_next_button():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	KnifeTip.hide()
	$NextButton.show()
 
## win points and update display
func update_score_display():
	if Score_Label!= null:
		Score_Label.text= "Score: "+ str(score) + " / " + str(total_possible_points)
	else:
		print("error")
		
#func play_cutting_sound():
	#$Knife/AudioStreamPlayer2D.play()
	#Cutting_Timer.start()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.


func _on_cutting_timer_timeout() -> void:
	$Knife/AudioStreamPlayer2D.stop()
