class_name Player extends CharacterBody2D

const SPEED = 300.0
const ACCELERATION = 200.0
const DECELERATION = 50.0

const GRAVITY_CONSTANT := 2000000.0

@onready var sprite_2d: Sprite2D = $Sprite2D

var dark_hole_pos: Vector2 = Vector2.ZERO
var near_dark_hole: bool = false

func _ready() -> void:
	sprite_2d.set_modulate(Color.BLACK)

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")

	if direction.length() > 0:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)

	# Handle sprite color toggle
	if Input.is_action_just_pressed(&"invert"):
		sprite_2d.set_modulate(Color.BLACK if sprite_2d.modulate == Color.WHITE else Color.WHITE)

#	# Handle Darkholes
	if near_dark_hole:
		var dist_sq = global_position.distance_squared_to(dark_hole_pos)
		if dist_sq > 0:
			var grav_dir = (dark_hole_pos - global_position).normalized()
			var grav_force = grav_dir * (GRAVITY_CONSTANT / dist_sq) * delta
			print(GRAVITY_CONSTANT / dist_sq)
			velocity += grav_force

	# Move the character
	var collision := move_and_slide()
	if collision:
		velocity = velocity.bounce(get_last_slide_collision().get_normal())

func die() -> void:
	print("Player died")

func enter_field(position: Vector2) -> void:
	print("Player entering a field")
	dark_hole_pos = position
	near_dark_hole = true

func exit_field() -> void:
	print("Player exiting a field")
	dark_hole_pos = Vector2.ZERO
	near_dark_hole = false
