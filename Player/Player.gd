extends CharacterBody2D

@export var speed       : float = 200.0
@export var gravity     : float = 800.0
@export var jump_force  : float = -350.0

var can_wall_jump : bool = true

func _physics_process(delta: float) -> void:
	# 1) Sterowanie poziome
	var dir := 0.0
	if Input.is_action_pressed("ui_right"):
		dir += 1
	if Input.is_action_pressed("ui_left"):
		dir -= 1
	velocity.x = dir * speed

	# 2) Reset wall-jump gdy na ziemi
	if is_on_floor():
		can_wall_jump = true

	# 3) Skok
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_force
		elif is_on_wall() and can_wall_jump:
			velocity.y = jump_force
			# odbij w poziomie od ściany
			var n = get_last_slide_collision().normal
			velocity.x = -n.x * speed
			can_wall_jump = false

	# 4) Grawitacja
	velocity.y += gravity * delta

	# 5) Przesunięcie
	move_and_slide()  # korzysta z tego.velocity

	# 6) Kamera podąża pionowo
	$Camera2D.position.y = global_position.y
