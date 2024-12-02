extends Node2D


# Array of ideal points along line at which cuts should be made
var ideal_cut_points = []
# Score variable
var lines=[]
var max_score = 100
var deduction_cut= 10
var total_cuts = 0
var score = max_score
var cut_threshold = 30
var first_space_pressed

# Ready function
func _ready() -> void:
	$NextButton.hide()
	$Onion.visible=false
	for child in get_children():
		if child is Line2D:
			lines.append(child)
			# Get the position of point 0
			var point_0_position = child.get_point_position(0)
			# Append the x-coordinate of point 0 to ideal_cut_points
			ideal_cut_points.append(point_0_position.x)
				
func _process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		if !first_space_pressed:
			first_space_pressed = true
			$TextBox.visible= false

		
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if first_space_pressed== true:
			if total_cuts < 4:
				total_cuts += 1
				print(total_cuts)
				##use marker2d position for knife
				var knife_position_x= $Knife/KnifeTip.global_position.x
				print("knife:",knife_position_x)
				if check_cut(knife_position_x):
					var points_loss= calculate_deduction(knife_position_x)
					print("cut is made", points_loss)
					$ChopSound.play()
				else:
					$ErrorSound.play()
					print("no cut is made")
					score-= deduction_cut
				update_score_display()
				score= max(score,0)
				print("current score: ", score)
				
		
			if total_cuts==3:
				$FullCarrot.visible= false
				$Onion.visible= true
				$Cut1.visible= false
				$Cut2.visible= false
				$Cut3.visible= true
				update_score_display()
				score= max(score,0)
				
			
			if total_cuts ==4:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				$NextButton.show()
				$ScoreBox/FinalScore.text = "Final Score: " + str(score) + "/100"
				$ScoreBox.show()
		#else:
			#get_tree().change_scene_to_file("res://kitchen.tscn")

func check_cut(knife_position_x):
	var cut_made = false
	for i in range(1,len(ideal_cut_points)):
		var cut_point= ideal_cut_points[i]
	#for cut_point in ideal_cut_points:
		print("cutx:",cut_point)
		if abs(knife_position_x - cut_point) <= cut_threshold:
			print("Successful cut at position:", knife_position_x,"and cut point", cut_point)
			lines[i].hide()
			cut_made= true
			break
		else:
			print("no cut made, not close enough",cut_point)
	return cut_made
		

func calculate_deduction(knife_position_x):
	var closest_distance = INF
	for cut_x in ideal_cut_points:
		var distance_from_cut = abs(knife_position_x- cut_x)
		if distance_from_cut < closest_distance:
			closest_distance = distance_from_cut
		
	var score_deduct= int(deduction_cut*(closest_distance/cut_threshold))
	return min(score_deduct, deduction_cut)

func show_next_button():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$KnifeTip.hide()
	$NextButton.show()
 
## win points and update display
func update_score_display():
	$Score_Label.text= str(score) 
		
#func play_cutting_sound():
	#$Knife/AudioStreamPlayer2D.play()
	#Cutting_Timer.start()

func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn")
	PlayerVariables.cutting_completed = true


func _on_cutting_timer_timeout() -> void:
	$Knife/AudioStreamPlayer2D.stop()
