extends State
class_name air_state

@export var player : CharacterBody2D
@export var anim : AnimatedSprite2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = 400
@export var gravity = 980
@export var coyote_time = 0.3

var coyote_timer = 0
func enter():
	print(player.has_jumped)
	coyote_timer = coyote_time
	anim.play("jump")

func exit():
	pass

func update(delta):
	pass

func physics_update(delta):
		# Add the gravity.
	coyote_timer -= delta
	
	if player.is_on_floor():
		Transitioned.emit(self, "walk_state")
	
	player.velocity.y += gravity*delta
	
	if player.velocity.y < 0: anim.play("jump")
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (not player.has_jumped and coyote_timer > 0):
		player.velocity.y = -JUMP_VELOCITY
		player.has_jumped = true
		print("jumped")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction > 0: anim.flip_h = false
	if direction < 0: anim.flip_h = true
	
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)

	player.move_and_slide()
