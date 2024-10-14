extends Area2D

@export var speed = 400
var screen_size
var start_position = Vector2(300, 300)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	position = mouse_position
	#if Input.is_action_pressed("move_right"):
		#velocity.x += 1
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= 1
	#if Input.is_action_pressed("move_down"):
		#velocity.y += 1
	#if Input.is_action_pressed("move_up"):
		#velocity.y -= 1

	#if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		#$AnimatedSprite2D.play()
	#else:
		#$AnimatedSprite2D.stop()
	
		
	#position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	#if velocity.x != 0:
		#$AnimatedSprite2D.animation = "move"
		###$AnimatedSprite2D.flip_v = false

		##$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = "move"
		###$AnimatedSprite2D.flip_v = velocity.y > 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
