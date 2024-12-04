extends Node2D
var ingredient_list
var selected_ingredients = []
var _overlapping = []
var correct_ingredients = PlayerVariables.correct_ingredients[PlayerVariables.curr_recipe]
var starting_score = 100
var dialogue_index = 0
var instructions = ["Drag the correct ingredients into the basket!", "Don't click the wrong ingredients!"]

var bacon_count = 0
var peas_count = 0
var cheese_count = 0
var dressing_count = 0
var carrot_count = 0
var steak_count = 0
var garlic_count = 0
var onion_count = 0
var potato_count = 0
var butter_count = 0
var sauce_count = 0
var raspberry_count = 0
var eggs_count = 0
var cakemix_count = 0
var water_count = 0
var jam_count = 0
var cream_count = 0

var mouse_offset = Vector3.ZERO;

func _ready() -> void:
	if $ScoreTextbox != null:
		$ScoreTextbox.hide()
	if $NextButton != null:
		$NextButton.hide()
	ingredient_list = get_tree().get_nodes_in_group("ingredients")
	if $InstructionsTextbox != null:
		if PlayerVariables.curr_recipe == 0:
			$InstructionsTextbox/Recipe2Pics.hide()
			$InstructionsTextbox/Recipe3Pics.hide()
		elif PlayerVariables.curr_recipe == 1:
			$InstructionsTextbox/Recipe1Pics.hide()
			$InstructionsTextbox/Recipe3Pics.hide()
		elif PlayerVariables.curr_recipe == 2:
			$InstructionsTextbox/Recipe1Pics.hide()
			$InstructionsTextbox/Recipe2Pics.hide()
		set_display()
	show_next_dialogue()

func show_next_dialogue():
	if dialogue_index < instructions.size():
		if $InstructionsTextbox != null:
			$InstructionsTextbox/InstructionText.text = instructions[dialogue_index]  # Updates the label with the current dialogue
			dialogue_index += 1
	else:
		$InstructionsTextbox.hide() 
	
func _input(event):
	if event.is_action_pressed("action"):
		if $InstructionsTextbox != null:
			$InstructionsTextbox/Recipe1Pics.hide()
			show_next_dialogue()
			

func _physics_process(delta: float) -> void:
	
	# updates position of whichever ingredient is currently being dragged
	for ingredient in ingredient_list:
		if ingredient.dragging:
			ingredient.global_position = get_global_mouse_position() + mouse_offset
			if ingredient.global_position.x >= 1350 and ingredient.global_position.x <= 2000 and ingredient.global_position.y >= 650 and ingredient.global_position.y <= 1150:
				ingredient.over_basket = true
			else:
				ingredient.over_basket = false
			

# updates score
func update_score():
	if $ScoreDisplay.text != null:
		$ScoreDisplay.text = "Score: " + str(starting_score)

# sets display
func set_display():
	if $VBoxContainer != null:
		if PlayerVariables.curr_recipe == 0:
			# "Peas", "Bacon", "Cheese", "Dressing"
			$VBoxContainer/ingredient_label1.text = "Bacon: " + str(bacon_count) + "/3"
			$VBoxContainer/ingredient_label2.text = "Peas: " + str(peas_count) + "/1"
			$VBoxContainer/ingredient_label3.text = "Cheese: " + str(cheese_count) + "/1"
			$VBoxContainer/ingredient_label4.text = "Salad Dressing: " + str(dressing_count) + "/1"
			$VBoxContainer/ingredient_label5.text = ""
			$VBoxContainer/ingredient_label6.text = ""
			$VBoxContainer/ingredient_label7.text = ""
			
			if bacon_count == 3 and peas_count == 1 and cheese_count == 1 and dressing_count == 1:
				$ScoreTextbox/Score.text = str(starting_score) + " points! Great job!"
				$ScoreTextbox.show()
				$NextButton.show()
				PlayerVariables.pantry_completed = true
				PlayerVariables.pantry_score = starting_score
				
		elif PlayerVariables.curr_recipe == 1:
			# "Carrots", "Steak", "Garlic", "Onion", "Potato", "Butter", "Steak Sauce"
			$VBoxContainer/ingredient_label1.text = "Carrots: " + str(carrot_count) + "/3"
			$VBoxContainer/ingredient_label2.text = "Steak: " + str(steak_count) + "/1"
			$VBoxContainer/ingredient_label3.text = "Garlic: " + str(garlic_count) + "/1"
			$VBoxContainer/ingredient_label4.text = "Onion: " + str(onion_count) + "/1"
			$VBoxContainer/ingredient_label5.text = "Potato: " + str(potato_count) + "/1"
			$VBoxContainer/ingredient_label6.text = "Butter: " + str(butter_count) + "/1"
			$VBoxContainer/ingredient_label7.text = "Steak Sauce: " + str(sauce_count) + "/1"
			
			if carrot_count == 3 and steak_count == 1 and garlic_count == 1 and onion_count == 1 and potato_count == 1 and butter_count == 1 and sauce_count == 1:
				$ScoreTextbox/Score.text = str(starting_score) + " points! Great job!"
				$ScoreTextbox.show()
				$NextButton.show()
				PlayerVariables.pantry_completed = true
				PlayerVariables.pantry_score = starting_score
		else: # recipe 3
			$VBoxContainer/ingredient_label1.text = "Raspberries: " + str(raspberry_count) + "/1"
			$VBoxContainer/ingredient_label2.text = "Eggs: " + str(eggs_count) + "/2"
			$VBoxContainer/ingredient_label3.text = "Cake Mix: " + str(cakemix_count) + "/1"
			$VBoxContainer/ingredient_label4.text = "Water: " + str(water_count) + "/1"
			$VBoxContainer/ingredient_label5.text = "Raspberry Jam: " + str(jam_count) + "/1"
			$VBoxContainer/ingredient_label6.text = "Butter: " + str(butter_count) + "/1"
			$VBoxContainer/ingredient_label7.text = "Whipped Cream: " + str(cream_count) + "/1"
			
			if raspberry_count == 1 and eggs_count == 2 and cakemix_count == 1 and butter_count == 1 and water_count == 1 and jam_count == 1 and cream_count == 1:
				$ScoreTextbox/Score.text = str(starting_score) + " points! Great job!"
				$ScoreTextbox.show()
				$NextButton.show()
				PlayerVariables.pantry_completed = true
				PlayerVariables.pantry_score = starting_score

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://kitchen.tscn")


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://kitchen.tscn") # Replace with function body.
	
# when ingredient is placed in basket
#func _on_basket_body_entered(body: RigidBody2D) -> void:
	#body.over_basket = true
	##Sprint(str(body) + " is now over basket")
#
#
#func _on_basket_body_exited(body: RigidBody2D) -> void:
	#body.over_basket = false
	##print(str(body) + " is not over basket")
		
# bounce at top of screen
func _on_top_boundary_body_entered(body: Node2D) -> void:
	body.move_speed.y *= -1
	body.set_velocity()

# bounce at bottom of screen
func _on_bottom_boundary_body_entered(body: Node2D) -> void:
	body.move_speed.y *= -1
	body.set_velocity()

# bounce at left of screen
func _on_left_boundary_body_entered(body: Node2D) -> void:
	body.move_speed.x *= -1
	body.set_velocity()

# bounce at right of screen
func _on_right_boundary_body_entered(body: Node2D) -> void:
	body.move_speed.x *= -1
	body.set_velocity()
	


# when carrot 1 is pressed
func _on_carrot_1_button_down() -> void:
	$Carrot1.dragging = true
	mouse_offset = $Carrot1.global_position - get_global_mouse_position()
	if $Carrot1.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()

# when carrot 1 is released
func _on_carrot_1_button_up() -> void:
	$Carrot1.dragging = false
	if $Carrot1.over_basket and $Carrot1.name in correct_ingredients:
		$Plop.play()
		$Carrot1.move_speed = Vector2.ZERO
		$Carrot1.set_velocity()
		$Carrot1.in_basket = true
		carrot_count += 1
		set_display()
		if carrot_count == 3:
			$VBoxContainer/ingredient_label1.modulate = Color(0, 1, 0)
	
# when carrot 2 is pressed
func _on_carrot_2_button_down() -> void:
	$Carrot2.dragging = true
	mouse_offset = $Carrot2.global_position - get_global_mouse_position()
	if $Carrot2.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()
	
# when carrot 2 is released
func _on_carrot_2_button_up() -> void:
	$Carrot2.dragging = false
	if $Carrot2.over_basket and $Carrot2.name in correct_ingredients:
		$Plop.play()
		$Carrot2.move_speed = Vector2.ZERO
		$Carrot2.set_velocity()
		$Carrot2.in_basket = true
		carrot_count += 1
		set_display()
		if carrot_count == 3:
			$VBoxContainer/ingredient_label1.modulate = Color(0, 1, 0)

# when carrot 3 is pressed
func _on_carrot_3_button_down() -> void:
	$Carrot3.dragging = true
	mouse_offset = $Carrot3.global_position - get_global_mouse_position()
	if $Carrot3.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()

# when carrot 3 is released
func _on_carrot_3_button_up() -> void:
	$Carrot3.dragging = false
	if $Carrot3.over_basket and $Carrot3.name in correct_ingredients:
		$Plop.play()
		$Carrot3.move_speed = Vector2.ZERO
		$Carrot3.set_velocity()
		$Carrot3.in_basket = true
		carrot_count += 1
		set_display()
		if carrot_count == 3:
			$VBoxContainer/ingredient_label1.modulate = Color(0, 1, 0)

# when peas are pressed
func _on_peas_button_down() -> void:
	$Peas.dragging = true
	mouse_offset = $Peas.global_position - get_global_mouse_position()
	if $Peas.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()

# when peas are released
func _on_peas_button_up() -> void:
	$Peas.dragging = false
	if $Peas.over_basket and $Peas.name in correct_ingredients:
		$Plop.play()
		$Peas.move_speed = Vector2.ZERO
		$Peas.set_velocity()
		$Peas.in_basket = true
		peas_count += 1
		set_display()
		$VBoxContainer/ingredient_label2.modulate = Color(0, 1, 0)


func _on_bacon_1_button_down() -> void:
	$Bacon1.dragging = true
	mouse_offset = $Bacon1.global_position - get_global_mouse_position()
	if $Bacon1.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_bacon_1_button_up() -> void:
	$Bacon1.dragging = false
	if $Bacon1.over_basket and $Bacon1.name in correct_ingredients:
		$Plop.play()
		$Bacon1.move_speed = Vector2.ZERO
		$Bacon1.set_velocity()
		$Bacon1.in_basket = true
		bacon_count += 1
		set_display()
		if bacon_count == 3:
			$VBoxContainer/ingredient_label1.modulate = Color(0, 1, 0)


func _on_bacon_2_button_down() -> void:
	$Bacon2.dragging = true
	mouse_offset = $Bacon2.global_position - get_global_mouse_position()
	if $Bacon2.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_bacon_2_button_up() -> void:
	$Bacon2.dragging = false
	if $Bacon2.over_basket and $Bacon2.name in correct_ingredients:
		$Plop.play()
		$Bacon2.move_speed = Vector2.ZERO
		$Bacon2.set_velocity()
		$Bacon2.in_basket = true
		bacon_count += 1
		set_display()
		if bacon_count == 3:
			$VBoxContainer/ingredient_label1.modulate = Color(0, 1, 0)


func _on_bacon_3_button_down() -> void:
	$Bacon3.dragging = true
	mouse_offset = $Bacon3.global_position - get_global_mouse_position()
	if $Bacon3.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_bacon_3_button_up() -> void:
	$Bacon3.dragging = false
	if $Bacon3.over_basket and $Bacon3.name in correct_ingredients:
		$Plop.play()
		$Bacon3.move_speed = Vector2.ZERO
		$Bacon3.set_velocity()
		$Bacon3.in_basket = true
		bacon_count += 1
		set_display()
		if bacon_count == 3:
			$VBoxContainer/ingredient_label1.modulate = Color(0, 1, 0)


func _on_cheese_button_down() -> void:
	$Cheese.dragging = true
	mouse_offset = $Cheese.global_position - get_global_mouse_position()
	if $Cheese.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_cheese_button_up() -> void:
	$Cheese.dragging = false
	if $Cheese.over_basket and $Cheese.name in correct_ingredients:
		$Plop.play()
		$Cheese.move_speed = Vector2.ZERO
		$Cheese.set_velocity()
		$Cheese.in_basket = true
		cheese_count += 1
		set_display()
		$VBoxContainer/ingredient_label3.modulate = Color(0, 1, 0)

	
func _on_dressing_button_down() -> void:
	$Dressing.dragging = true
	mouse_offset = $Dressing.global_position - get_global_mouse_position()
	if $Dressing.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_dressing_button_up() -> void:
	$Dressing.dragging = false
	if $Dressing.over_basket and $Dressing.name in correct_ingredients:
		$Plop.play()
		$Dressing.move_speed = Vector2.ZERO
		$Dressing.set_velocity()
		$Dressing.in_basket = true
		dressing_count += 1
		set_display()
		$VBoxContainer/ingredient_label4.modulate = Color(0, 1, 0)


func _on_steak_button_down() -> void:
	$Steak.dragging = true
	mouse_offset = $Steak.global_position - get_global_mouse_position()
	if $Steak.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_steak_button_up() -> void:
	$Steak.dragging = false
	if $Steak.over_basket and $Steak.name in correct_ingredients:
		$Plop.play()
		$Steak.move_speed = Vector2.ZERO
		$Steak.set_velocity()
		$Steak.in_basket = true
		steak_count += 1
		set_display()
		$VBoxContainer/ingredient_label2.modulate = Color(0, 1, 0)


func _on_potato_button_down() -> void:
	$Potato.dragging = true
	mouse_offset = $Potato.global_position - get_global_mouse_position()
	if $Potato.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_potato_button_up() -> void:
	$Potato.dragging = false
	if $Potato.over_basket and $Potato.name in correct_ingredients:
		$Plop.play()
		$Potato.move_speed = Vector2.ZERO
		$Potato.set_velocity()
		$Potato.in_basket = true
		potato_count += 1
		set_display()
		$VBoxContainer/ingredient_label5.modulate = Color(0, 1, 0)


func _on_butter_button_down() -> void:
	$Butter.dragging = true
	mouse_offset = $Butter.global_position - get_global_mouse_position()
	if $Butter.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_butter_button_up() -> void:
	$Butter.dragging = false
	if $Butter.over_basket and $Butter.name in correct_ingredients:
		$Plop.play()
		$Butter.move_speed = Vector2.ZERO
		$Butter.set_velocity()
		$Butter.in_basket = true
		butter_count += 1
		set_display()
		$VBoxContainer/ingredient_label6.modulate = Color(0, 1, 0)
	

func _on_garlic_button_down() -> void:
	$Garlic.dragging = true
	mouse_offset = $Garlic.global_position - get_global_mouse_position()
	if $Garlic.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_garlic_button_up() -> void:
	$Garlic.dragging = false
	if $Garlic.over_basket and $Garlic.name in correct_ingredients:
		$Plop.play()
		$Garlic.move_speed = Vector2.ZERO
		$Garlic.set_velocity()
		$Garlic.in_basket = true
		garlic_count += 1
		set_display()
		$VBoxContainer/ingredient_label3.modulate = Color(0, 1, 0)


func _on_onion_button_down() -> void:
	$Onion.dragging = true
	mouse_offset = $Onion.global_position - get_global_mouse_position()
	if $Onion.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_onion_button_up() -> void:
	$Onion.dragging = false
	if $Onion.over_basket and $Onion.name in correct_ingredients:
		$Plop.play()
		$Onion.move_speed = Vector2.ZERO
		$Onion.set_velocity()
		$Onion.in_basket = true
		onion_count += 1
		set_display()
		$VBoxContainer/ingredient_label4.modulate = Color(0, 1, 0)


func _on_sauce_button_down() -> void:
	$SteakSauce.dragging = true
	mouse_offset = $SteakSauce.global_position - get_global_mouse_position()
	if $SteakSauce.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_sauce_button_up() -> void:
	$SteakSauce.dragging = false
	if $SteakSauce.over_basket and $SteakSauce.name in correct_ingredients:
		$Plop.play()
		$SteakSauce.move_speed = Vector2.ZERO
		$SteakSauce.set_velocity()
		$SteakSauce.in_basket = true
		sauce_count += 1
		set_display()
		$VBoxContainer/ingredient_label7.modulate = Color(0, 1, 0)


func _on_raspberry_button_down() -> void:
	$Raspberries.dragging = true
	mouse_offset = $Raspberries.global_position - get_global_mouse_position()
	if $Raspberries.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score()


func _on_raspberry_button_up() -> void:
	$Raspberries.dragging = false
	if $Raspberries.over_basket and $Raspberries.name in correct_ingredients:
		$Plop.play()
		$Raspberries.move_speed = Vector2.ZERO
		$Raspberries.set_velocity()
		$Raspberries.in_basket = true
		raspberry_count += 1
		set_display()
		$VBoxContainer/ingredient_label1.modulate = Color(0, 1, 0) # Replace with function body.



func _on_egg_1_button_down() -> void:
	$Egg1.dragging = true
	mouse_offset = $Egg1.global_position - get_global_mouse_position()
	if $Egg1.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score() # Replace with function body.


func _on_egg_1_button_up() -> void:
	$Egg1.dragging = false
	if $Egg1.over_basket and $Egg1.name in correct_ingredients:
		$Plop.play()
		$Egg1.move_speed = Vector2.ZERO
		$Egg1.set_velocity()
		$Egg1.in_basket = true
		eggs_count += 1
		set_display()
		if eggs_count == 2:
			$VBoxContainer/ingredient_label2.modulate = Color(0, 1, 0) # Replace with function body.


func _on_egg_2_button_down() -> void:
	$Egg2.dragging = true
	mouse_offset = $Egg2.global_position - get_global_mouse_position()
	if $Egg2.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score() # Replace with function body.


func _on_egg_2_button_up() -> void:
	$Egg2.dragging = false
	if $Egg2.over_basket and $Egg2.name in correct_ingredients:
		$Plop.play()
		$Egg2.move_speed = Vector2.ZERO
		$Egg2.set_velocity()
		$Egg2.in_basket = true
		eggs_count += 1
		set_display()
		if eggs_count == 2:
			$VBoxContainer/ingredient_label2.modulate = Color(0, 1, 0) # Replace with function body.


func _on_cake_mix_button_down() -> void:
	$CakeMix.dragging = true
	mouse_offset = $CakeMix.global_position - get_global_mouse_position()
	if $CakeMix.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score() # Replace with function body.


func _on_cake_mix_button_up() -> void:
	$CakeMix.dragging = false
	if $CakeMix.over_basket and $CakeMix.name in correct_ingredients:
		$Plop.play()
		$CakeMix.move_speed = Vector2.ZERO
		$CakeMix.set_velocity()
		$CakeMix.in_basket = true
		cakemix_count += 1
		set_display()
		$VBoxContainer/ingredient_label3.modulate = Color(0, 1, 0) # Replace with function body.


func _on_water_button_down() -> void:
	$Water.dragging = true
	mouse_offset = $Water.global_position - get_global_mouse_position()
	if $Water.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score() # Replace with function body.


func _on_water_button_up() -> void:
	$Water.dragging = false
	if $Water.over_basket and $Water.name in correct_ingredients:
		$Plop.play()
		$Water.move_speed = Vector2.ZERO
		$Water.set_velocity()
		$Water.in_basket = true
		water_count += 1
		set_display()
		$VBoxContainer/ingredient_label4.modulate = Color(0, 1, 0) # Replace with function body.


func _on_raspberry_jam_button_down() -> void:
	$RaspberryJam.dragging = true
	mouse_offset = $RaspberryJam.global_position - get_global_mouse_position()
	if $RaspberryJam.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score() # Replace with function body.


func _on_raspberry_jam_button_up() -> void:
	$RaspberryJam.dragging = false
	if $RaspberryJam.over_basket and $RaspberryJam.name in correct_ingredients:
		$Plop.play()
		$RaspberryJam.move_speed = Vector2.ZERO
		$RaspberryJam.set_velocity()
		$RaspberryJam.in_basket = true
		jam_count += 1
		set_display()
		$VBoxContainer/ingredient_label5.modulate = Color(0, 1, 0) # Replace with function body.


func _on_whipped_cream_button_down() -> void:
	$WhippedCream.dragging = true
	mouse_offset = $WhippedCream.global_position - get_global_mouse_position()
	if $WhippedCream.name not in correct_ingredients:
		starting_score -= 10
		if starting_score < 0:
			starting_score = 0
		update_score() # Replace with function body.


func _on_whipped_cream_button_up() -> void:
	$WhippedCream.dragging = false
	if $WhippedCream.over_basket and $WhippedCream.name in correct_ingredients:
		$Plop.play()
		$WhippedCream.move_speed = Vector2.ZERO
		$WhippedCream.set_velocity()
		$WhippedCream.in_basket = true
		cream_count += 1
		set_display()
		$VBoxContainer/ingredient_label7.modulate = Color(0, 1, 0) # Replace with function body.
