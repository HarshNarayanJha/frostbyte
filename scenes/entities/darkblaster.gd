extends StaticBody2D


@export var shoot_freq := 0.1
@export var shoot_strength := 100
@export var darktriangle: PackedScene

@onready var shoot_timer: Timer = $ShootTimer
@onready var tip: Marker2D = $Tip

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot_timer.wait_time = 1 / shoot_freq
	shoot_timer.timeout.connect(shoot_triangle)
	shoot_timer.start()

func _exit_tree() -> void:
	shoot_timer.timeout.disconnect(shoot_triangle)

func _process(delta: float) -> void:
	pass

func shoot_triangle() -> void:
	var tri: DarkTriangle = darktriangle.instantiate()
	add_child(tri)
	tri.position = tip.position
	tri.fire(transform.basis_xform(Vector2.DOWN), shoot_strength)
