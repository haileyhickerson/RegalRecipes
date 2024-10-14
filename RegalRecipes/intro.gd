extends Node2D

#dialogue lines
var dialogue = [
	"Welcome, young cook, to the Grand Kitchen
	of Figglebottom Estate!",
	"My name is Barnaby Butterspoon, and I am 
	the current chef for the Royal Figglebottom Family.",
	"I've been told that you excelled in your Culinary 
	Studies at the prestigious Kingsford University, 
	which is a very impressive feat.",
	"Given that I plan to retire soon, I will be needing 
	someone to take over my position, and I believe you 
	would be a great candidate for the role.",
	"However, success in an academic setting is quite 
	different from that of a high-pressure, high-stakes 
	environment such as this one.",
	"Not just anyone can make it as a chef for the 
	Figglebottoms. They're stubborn, impatient, and highly 
	critical when it comes to their food.",
	"Over the course of my tenure, I have learned to cater 
	to their very particular tastes, and, now, I want to 
	see if you have what it takes to do the same.",
	"I will be teaching you how to make the Figglebottoms' 
	favorite dishes in order to put your skills to the test.",
	"I shall guide you through each step with a watchful eye, 
	and, at the end, you shall serve your food to the Royal 
	Family and face their judgment.",
	"Remember to be swift, but precise! Good Luck."
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
	#if $Button:  # if you're using a Button
		#$Button.hide()
	
	get_tree().change_scene_to_file("res://kitchen.tscn")
