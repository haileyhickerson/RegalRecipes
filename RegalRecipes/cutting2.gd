extends Node2D


# Array of ideal points along line at which cuts should be made
var ideal_cut_points = []
# Score variable
var score = 0
var total_possible_points = 100
var total_cuts = 0
var cut_threshold = 30
var first_space_pressed

# Ready function
func _ready() -> void:
	$NextButton.hide()
	$Onion.visible=false
	for child in get_children():
		if child is Line2D:
			var points = child.points
			for point in points:
				ideal_cut_points.append(point.x)
			print(ideal_cut_points)
				
func _process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		if !first_space_pressed:
			first_space_pressed = true
			$TextBox.visible= false

		
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		total_cuts += 1
		if total_cuts < 4:
			print(total_cuts)
			##use marker2d position for knife
			var knife_position_x= $Knife/KnifeTip.global_position.x
			print("knife:",knife_position_x)
			if check_cut(knife_position_x):
				var points_gained= calculate_score(knife_position_x)
				score += points_gained
				update_score_display()
				print("cut is made, score: ", score)
			else:
				update_score_display()
				print("no cut is made, score: ", score)
				
				
	
		if total_cuts==3:
			$FullCarrot.visible= false
			$Onion.visible= true
			$Cut1.visible= false
			$Cut2.visible= false
			
		
		if total_cuts ==4:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
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
	if point_distances.size()==0:
		print("no points to calculate")
		return 0
	var closest_distance= point_distances.min()
	var points= int((100 -closest_distance)/3)
	if score<=0:
		score=0
		
	return points
	
func check_cut_accuracy(knife_position_x, cut_x):
	return abs(knife_position_x - cut_x)

func show_next_button():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$KnifeTip.hide()
	$NextButton.show()
 
## win points and update display
func update_score_display():
	$Score/Score_Label.text= "Score: "+ str(score) + " / " + str(total_possible_points)

		
#func play_cutting_sound():
	#$Knife/AudioStreamPlayer2D.play()
	#Cutting_Timer.start()

func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn")
	PlayerVariables.cutting_completed = true


func _on_cutting_timer_timeout() -> void:
	$Knife/AudioStreamPlayer2D.stop()
