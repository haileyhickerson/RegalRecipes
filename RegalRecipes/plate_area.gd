extends Area2D

var cheese_targets: Array = []
var bacon_targets: Array =[]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cheese_targets= [get_node("../TargetSpots/CheeseTarget1"), get_node("../TargetSpots/CheeseTarget2"), get_node("../TargetSpots/CheeseTarget3")]
	
	bacon_targets=[get_node("../TargetSpots/BaconTarget1"), get_node("../TargetSpots/BaconTarget2"), get_node("../TargetSpots/BaconTarget3")]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_Plate_area_entered(area: Area2D) -> void:
	if area.is_in_group("plating_ingredients"):
		print(area.name + " entered the plate area")
		check_placement(area)
		
func check_placement(ingredient: Area2D):
	print("checking")
	var ingredient_position = ingredient.global_position
	print("Ingredient global position: ", ingredient_position)
	for target in cheese_targets:
		var target_position = target.global_position
		print("Target global position: ", target_position)

		#print("Parent position: ", ingredient.get_parent().global_position)
		#var adjusted_position = ingredient.global_position - ingredient.get_parent().global_position
		#print("adjusted position: ",adjusted_position)
		print(ingredient)
		if ingredient_position.distance_to(target_position)<50:
			print(ingredient.name+ "correctly placed in target: "+ target.name)
			return
		#var placed_correctly= false
		#for target in cheese_targets:
			#print("my ingredient ", area)
			#print("my target ", target)
			#if area.get_overlapping_areas().has(target) and target.get_overlapping_areas().has(area):
				#print(area.name + " correctly placed in cheese target: "+ target.name)
				#placed_correctly= true
				#break
	##for target in bacon_targets:
		##if is_instance_valid(area)and area.is_overlapping(target):
			##placed_correctly= true
			##print(area.name+" correctly placed in bacon target")
			##break
	#if not placed_correctly:
		#print(area.name)
