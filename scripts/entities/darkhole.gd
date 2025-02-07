extends StaticBody2D

@onready var gravity_area: Area2D = $GravityArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_area.body_entered.connect(try_apply_gravity)
	gravity_area.body_exited.connect(remove_gravity)

func _exit_tree() -> void:
	gravity_area.body_entered.disconnect(try_apply_gravity)
	gravity_area.body_exited.disconnect(remove_gravity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func try_apply_gravity(body: Node2D) -> void:
	if body is not Player:
		return

	var player := body as Player
	player.enter_field(global_position)

func remove_gravity(body: Node2D) -> void:
	if body is not Player:
		return

	var player := body as Player
	player.exit_field()
