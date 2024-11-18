extends Node2D
var first_space_pressed
var plate_center=960
var total_score=0
func _ready():
	# set the direction and speed to each layer
	$SpongeLayer1.set_direction_and_speed(1, 380)
	$RasberryFilling.set_direction_and_speed(-1, 450)
	$SpongeLayer2.set_direction_and_speed(1, 300)
	$Frosting.set_direction_and_speed(-1, 310)

func _process(delta: float) -> void:
	if Input.is_action_pressed("action"):
		if !first_space_pressed:
			first_space_pressed = true
			$TextBox.visible= false


func _on_layer_1_button_up() -> void:
	stack_layer($SpongeLayer1)
	var layer1_score = calculate_score($SpongeLayer1)
	total_score += layer1_score
	print("Layer 1 score: ", layer1_score)
	update_score_display()

func _on_layer_2_button_up() -> void:
	stack_layer($RasberryFilling)
	var layer2_score=calculate_score($RasberryFilling)
	total_score += layer2_score
	print("Layer 2 score: ", layer2_score)
	update_score_display()
		
func _on_layer_3_button_up() -> void:
	stack_layer($SpongeLayer2)
	var layer3_score= calculate_score($SpongeLayer2)
	total_score += layer3_score
	print("Layer 3 score: ", layer3_score)
	update_score_display()
		
func _on_layer_4_button_up() -> void:
	stack_layer($Frosting)
	var layer4_score= calculate_score($Frosting)
	total_score += layer4_score
	print("Layer 4 score: ", layer4_score)
	print(total_score)
	update_score_display()
	
func calculate_score(layer):
	var alignment_threshold = 60  
	var max_points = 25# Allow a margin for the alignment (you can adjust this)
	print(layer.position.x)
	var distance_from_center = abs(layer.position.x - plate_center)
	# Calculate the score based on distance from the center (out of 25)
	if distance_from_center <= alignment_threshold:
		# Calculate the score as a percentage of how close it is
		var score = max_points * (1 - (distance_from_center / alignment_threshold))
		return int(score)
	else:
		return 0
# Function to stack a layer
func stack_layer(layer):
	# Stop the layer from moving by setting speed to 0
	layer.speed =0
	layer.direction = 0  # Optionally stop its movement

func update_score_display():
	$Score.text= str(total_score)
