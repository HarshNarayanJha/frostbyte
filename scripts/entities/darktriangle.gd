class_name DarkTriangle extends RigidBody2D

@onready var darkzone: Area2D = $Darkzone

func _ready() -> void:
	darkzone.body_entered.connect(on_body_entered)

func _exit_tree() -> void:
	darkzone.body_entered.disconnect(on_body_entered)

func _physics_process(delta: float) -> void:
	self.apply_torque(500 * delta)

func fire(direction: Vector2, speed: float) -> void:
	var rand_dir = direction.rotated(randf_range(-0.5, 0.5))
	self.apply_impulse(rand_dir * speed)

	get_tree().create_timer(10).timeout.connect(queue_free)

func on_body_entered(body: Node2D) -> void:
	if body is Player:
		(body as Player).die()
