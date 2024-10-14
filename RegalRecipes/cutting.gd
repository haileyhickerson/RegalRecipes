extends Node2D

@export var Cut1: Line2D
@export var Cut2: Line2D
@export var Cut3: Line2D
@export var Score_Label: Label

# Array of ideal points along line at which cuts should be made
var ideal_cut_points = []
# Score variable
var score = 0
var total_possible_points = 0

var total_cuts = 0

# Ready function
func _ready() -> void:
	$NextButton.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_process_input(true)
	ideal_cut_points=[Cut1.points, Cut2.points, Cut3.points]

# the cut threshold (distance from cut points)
var cut_threshold = 100.0

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if total_cuts < 3:
			total_cuts += 1
			var knife_position= $Knife/KnifeTip.global_position
			print(knife_position)
			var points_gained=0
			var point_distances = []
			for cut_points in ideal_cut_points:
				point_distances.append(check_cut_accuracy(knife_position,cut_points))
			var closest_distance = point_distances.min()
			score += 100 - int(closest_distance)
			if score < 0:
				score = 0
			total_possible_points += 100
			update_score_display()
			if total_cuts == 3:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				$Knife.hide()
				$NextButton.show()
		else:
			get_tree().change_scene_to_file("res://kitchen.tscn")

			
func check_cut_accuracy(knife_position: Vector2, cut_points:Array):
		# Get the two points from the line
	for i in range(0, cut_points.size()-1):
		var point_a = cut_points[i]
		var point_b =cut_points[i+1]
		var distance: float = point_to_line_distance(knife_position,point_a, point_b)
		# check if the knife is near either point
		return distance

func point_to_line_distance(point:Vector2, point_a:Vector2, point_b:Vector2)->float:
	var line_vector: Vector2= point_b - point_a
	var line_length: float= line_vector.length()
	if line_length == 0:
		return point.distance_to(point_a)
	var projection: float = clamp(((point - point_a).dot(line_vector) / line_length), 0, line_length)
	var closest_point: Vector2= point_a+line_vector.normalized()*projection
	return point.distance_to(closest_point)

# win points and update display
func update_score_display():
	if Score_Label!= null:
		Score_Label.text= "Score: "+ str(score) + " / " + str(total_possible_points)
	else:
		print("error")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.
