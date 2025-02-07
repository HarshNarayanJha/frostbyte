extends Node
class_name InputHandler

var direction := Vector2.ZERO
var active := true

func update() -> void:
	if not active:
		return
	direction = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")

func enable_inputs() -> void:
	active = true

func disable_inputs() -> void:
	active = false
