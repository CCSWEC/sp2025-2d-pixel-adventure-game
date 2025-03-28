extends State
class_name walk_state

@export var player : CharacterBody2D
@export var anim : AnimatedSprite2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = 400
@export var coyote_time = 0.3

func enter():
	player.has_jumped = false
	anim.play("default")

func exit():
	pass

func update(delta):
	pass

func physics_update(delta):
		# Add the gravity.
	if not player.is_on_floor():
		Transitioned.emit(self, "air_state")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and not player.has_jumped:
		player.velocity.y = -JUMP_VELOCITY
		player.has_jumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if anim.animation == "default" and abs(direction) > 0:
		anim.play("walk")
	elif anim.animation == "walk" and abs(direction) <= 0:
		anim.play("default")
	
	if direction > 0: anim.flip_h = false
	if direction < 0: anim.flip_h = true
	
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)

	player.move_and_slide()
