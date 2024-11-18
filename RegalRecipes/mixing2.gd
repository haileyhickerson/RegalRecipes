extends Node2D

# array containing all 8 marker2d's along the circle
var marker_array

# gameobject variable denoting the currently active marker
var current_marker
# int denoting the index of the currently active marker
var current_marker_index

var first_space_pressed
var second_space_pressed

# boolean to determine if the player is currently attempting to complete the station
var station_part1_begin
var station_part2_begin
# boolean to determine if the player has started their first attempt
var first_station_begin
# boolean to denote if the player has completed the station
var station_part1_completed
var station_completed

# boolean to check if the mouse is within the target circle of the station
var exited_circle

# float to store the amount of time elapsed since first attempting the station
var time_elapsed := 0.0
var final_time

var final_score = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	station_completed = false
	station_part1_completed = false
	first_station_begin = false
	first_space_pressed = false
	second_space_pressed = false
	marker_array = [$Marker1, $Marker2, $Marker3,$Marker4,
					$Marker5, $Marker6, $Marker7, $Marker8]
	$NextButton.hide()
	$StartButton.hide()
	$SteakSauce.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		if !first_space_pressed:
			$TextBox/Instructions.hide()
			$TextBox/Instructions2.show()
			await get_tree().create_timer(0.5).timeout
			first_space_pressed = true
		elif first_space_pressed and !second_space_pressed:
			second_space_pressed = true
			$TextBox/Instructions2.hide()
			$TextBox/Instructions3.show()
			$TextBox/PressSpace.hide()
			$TextBox/Instructions3/ArrowStart.play()
			$StartButton.show()
			
	if first_station_begin && !station_completed:
		time_elapsed += delta
		$Timer.text = str(int(time_elapsed))
		
	if !station_part1_begin:
		$MarkerButton.hide()
		$StartButton.show()
		current_marker_index = 0
		current_marker = marker_array[current_marker_index]
		
	if station_part1_completed and !station_part2_begin:
		current_marker_index = 0
		current_marker = marker_array[current_marker_index]
		
	if station_part1_begin && !station_part1_completed:
		$TextBox.hide()
		if first_station_begin == false:
			first_station_begin = true
		$StartButton.hide()
		$MarkerButton.global_position = current_marker.global_position
		$MarkerButton.show()
		if exited_circle:
			reset_mixing_1()
			
	if station_part1_completed and station_part2_begin and !station_completed:
		$StartButton.hide()
		$MarkerButton.global_position = current_marker.global_position
		$MarkerButton.show()
		if exited_circle:
			reset_mixing_2()
			
	if station_completed:
		await get_tree().create_timer(1.5).timeout
		PlayerVariables.mixing_completed = true
		final_time = int(time_elapsed)
		$MarkerButton.hide()
		var score_deduction = int(final_time - 20)
		if score_deduction < 0:
			score_deduction = 0
		final_score = 100 - score_deduction
		PlayerVariables.mixing_score = final_score
		$ScoreBox/FinalScore.text = "Final Score: " + str(final_score) + "/100"
		$ScoreBox.show()
			
func reset_mixing_1():
		station_part1_begin = false
		
func reset_mixing_2():
	station_part2_begin = false
	$MarkerButton.hide()
	$StartButton.show()
	
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.

func _on_outside_of_circle_mouse_entered() -> void:
	exited_circle = true

func _on_outside_of_circle_mouse_exited() -> void:
	exited_circle = false

func _on_start_button_pressed() -> void:
	if !station_part1_completed:
		station_part1_begin = true
	else:
		station_part2_begin = true


func _on_marker_button_pressed() -> void:
	if !station_part1_completed:
		if current_marker_index != 7:
			$SteakSauce.play("mix")
			current_marker_index += 1
			current_marker = marker_array[current_marker_index]
		else:
			station_part1_complete()
	else:
		$SteakText.hide()
		if current_marker_index != 7:
			$SteakSauce.play("steak_mix")
			current_marker_index += 1
			current_marker = marker_array[current_marker_index]
		else:
			station_complete()
		
func station_part1_complete():
	station_part1_completed = true
	$MarkerButton.hide()
	$SteakSauce.play("mixed")
	await get_tree().create_timer(1.5).timeout
	$SteakSauce.play("steak_enter")
	$SteakText.show()
	station_part2_begin = true
	await get_tree().create_timer(1.0).timeout
	$SteakSauce.play("steak_idle")
	
func station_complete():
	station_completed = true
	$MarkerButton.hide()
	$SteakSauce.play("steak_mixed")
	await get_tree().create_timer(1.5).timeout
	$OutsideOfSquare.hide()
	$NextButton.show()


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn")
