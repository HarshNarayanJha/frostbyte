class_name Exit extends Area2D

func _ready() -> void:
	self.body_entered.connect(on_body_entered)

func _exit_tree() -> void:
	self.body_entered.disconnect(on_body_entered)

func _process(delta: float) -> void:
	pass

func on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Level Cleared")
