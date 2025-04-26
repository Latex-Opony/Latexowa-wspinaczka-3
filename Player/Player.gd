extends CharacterBody2D

@export var speed := 200.0
@export var gravity := 500.0
@export var jump_velocity := -300.0

func _physics_process(delta):
	# Dodajemy grawitację
	if not is_on_floor():
		velocity.y += gravity * delta

	# Ruch w poziomie
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	else:
		velocity.x = 0

	# Skok
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Przesuwamy węzeł i aktualizujemy velocity
	move_and_slide()
