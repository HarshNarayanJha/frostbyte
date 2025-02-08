class_name DarkPlane extends Sprite2D

@export var rotation_speed := 0.25
@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	area_2d.body_entered.connect(on_body_entered)

func _exit_tree() -> void:
	area_2d.body_entered.disconnect(on_body_entered)


func _process(delta: float) -> void:
	self.rotate(rotation_speed * delta)

func on_body_entered(body: Node2D) -> void:
	if body is Player and not body.dying:
		(body as Player).die()
