extends Node
class_name InputHandler

var direction := Vector2.ZERO

func update() -> void:
	direction = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
