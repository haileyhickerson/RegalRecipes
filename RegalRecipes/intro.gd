extends Node2D

#dialogue lines
var dialogue = [
	"Welcome to the royal kitchen!",
	"I'll guide you through your tasks today.",
	"Remember to be fast & but accurate! Good Luck"
]

# intialize to track the current dialogue index
var dialogue_index = 0

# Called when the node enters the scene tree for the first time
func _ready():
	show_next_dialogue()

# function to display the next dialogue line
func show_next_dialogue():
	if dialogue_index < dialogue.size():
		$Panel/Label.text = dialogue[dialogue_index]  # Updates the label with the current dialogue
		dialogue_index += 1
	else:
		hide_dialogue()  # If no more dialogue, hide the dialogue box

# player advances dialogue
func _input(event):
	if event.is_action_pressed("action"):
		show_next_dialogue()

# hide dialogue box when the conversation is over
func hide_dialogue():
	$Panel.hide()  # hides the Panel (dialogue box)
	get_tree().change_scene_to_file("res://kitchen.tscn")
