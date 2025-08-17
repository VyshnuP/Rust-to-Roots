extends CharacterBody2D


@export var speed : float = 80.0
@export var jump_velocity : float = -200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	  
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right","up","down")
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
	if is_on_floor() and animation_locked:
		animation_locked = false
	
	update_animation()
	update_facing_direction()

func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("walk")
		else:
				animated_sprite.play("idle") 

func update_facing_direction():
	if direction.x >0:
		animated_sprite.flip_h = false
	elif direction.x <0:
		animated_sprite.flip_h = true

func jump():
	velocity.y = jump_velocity
	animated_sprite.play("jump")
	animation_locked = true
	
