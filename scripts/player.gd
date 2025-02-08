class_name Player extends CharacterBody2D

const SPEED := 300.0
const ACCELERATION := 200.0
const DECELERATION := 50.0

const GRAVITY_CONSTANT := 1000000.0

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var input: InputHandler
@export var die_fx: PackedScene
@export var cam_shake: PhantomCameraNoiseEmitter2D

@export_group("Audio")
@export var die_sfxs: Array[AudioStream]

var dark_hole_pos: Array[Vector2] = []
var near_dark_hole: bool = false

var dying := false

func _ready() -> void:
	sprite_2d.set_modulate(Color.BLACK)

func _physics_process(delta: float) -> void:
	input.update()

	var direction := input.direction

	if direction.length() > 0:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)

	# Handle Darkholes
	if near_dark_hole:
		for h in dark_hole_pos:
			var dist_sq = global_position.distance_squared_to(h)
			if dist_sq > 0:
				var grav_dir = (h - global_position).normalized()
				var grav_force = grav_dir * (GRAVITY_CONSTANT / dist_sq) * delta
				velocity += grav_force

	# Move the character
	var collision := move_and_slide()
	if collision:
		if not dying:
			Globals.new_hit()
		velocity = velocity.bounce(get_last_slide_collision().get_normal())

func die() -> void:
	if dying:
		return

	dying = true
	input.disable_inputs()
	cam_shake.emit()
	Globals.new_die()
	velocity = Vector2.ZERO
	sprite_2d.hide()

	var fx: GPUParticles2D = die_fx.instantiate()
	add_child(fx)
	fx.emitting = true
	MusicPlayer.play_sfx(die_sfxs.pick_random(), global_position)

	await fx.finished
	SceneManager.reload_scene({"pattern": "scribbles", "wait_time": 1, "speed": 5})

func enter_field(at: Vector2) -> void:
	dark_hole_pos.append(at)
	near_dark_hole = true

func exit_field(at: Vector2) -> void:
	dark_hole_pos.erase(at)
	if dark_hole_pos.size() == 0:
		near_dark_hole = false
