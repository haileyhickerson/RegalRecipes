extends Node2D

# array containing all 8 marker2d's along the circle
var marker_array
# array containing all 8 arrows along the circle
var arrow_array

# gameobject variable denoting the currently active marker
var current_marker
# gameobject variable denoting the currently active arrow
var current_arrow
# int denoting the index of the currently active marker
var current_marker_index

# boolean to determine if the player is currently attempting to complete the station
var station_begin
# boolean to determine if the player has started their first attempt
var first_station_begin
# boolean to denote if the player has completed the station
var station_completed

# boolean to check if the mouse is within the target circle of the station
var exited_circle

# float to store the amount of time elapsed since first attempting the station
var time_elapsed := 0.0
var final_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	station_completed = false
	first_station_begin = false
	marker_array = [$Marker1, $Marker2, $Marker3,$Marker4,
					$Marker5, $Marker6, $Marker7, $Marker8]
	arrow_array = [$Arrow1, $Arrow2, $Arrow3, $Arrow4,
					$Arrow5, $Arrow6, $Arrow7, $Arrow8,]
	$NextButton.hide()
	$Peas.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if first_station_begin && !station_completed:
		time_elapsed += delta
		$Timer.text = str(int(time_elapsed))
		
	if !station_begin:
		for arrow in arrow_array:
				arrow.hide()
		$MarkerButton.hide()
		$StartButton.show()
		current_marker_index = 0
		current_marker = marker_array[current_marker_index]
		current_arrow = arrow_array[current_marker_index]
		
	if station_begin && !station_completed:
		$TextBox.hide()
		if first_station_begin == false:
			first_station_begin = true
		$StartButton.hide()
		$MarkerButton.global_position = current_marker.global_position
		$MarkerButton.show()
		current_arrow.show()
		if exited_circle:
			reset_mixing()
	if station_completed:
		final_time = int(time_elapsed)
		for arrow in arrow_array:
			arrow.hide()
			$MarkerButton.hide()
			
func reset_mixing():
		station_begin = false
	
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.

func _on_outside_of_circle_mouse_entered() -> void:
	exited_circle = true

func _on_outside_of_circle_mouse_exited() -> void:
	exited_circle = false

func _on_start_button_pressed() -> void:
	station_begin = true


func _on_marker_button_pressed() -> void:
	$Peas.play("mix")
	if current_marker_index != 7:
		current_arrow.hide()
		current_marker_index += 1
		current_marker = marker_array[current_marker_index]
		current_arrow = arrow_array[current_marker_index]
	else:
		station_complete()
		
func station_complete():
	station_completed = true
	$Peas.play("mixed")
	$OutsideOfCircle.hide()
	$NextButton.show()


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn")
