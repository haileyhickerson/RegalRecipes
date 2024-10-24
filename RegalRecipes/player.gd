extends Area2D

@export var speed = 400
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = PlayerVariables.location
	if PlayerVariables.chef_selected == 1:
		$AnimatedSprite2D.animation = "chef1"
	if PlayerVariables.chef_selected == 2:
		$AnimatedSprite2D.animation = "chef2"

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO 
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		if $FootstepSound.playing == false:
			$FootstepSound.play()
	else:
		$AnimatedSprite2D.stop()
		$FootstepSound.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	PlayerVariables.location = global_position
	
	#if velocity.x != 0:
		#$AnimatedSprite2D.animation = "walk"
		##$AnimatedSprite2D.flip_v = false

		##$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = "walk"
		##$AnimatedSprite2D.flip_v = velocity.y > 0
