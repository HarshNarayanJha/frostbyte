extends StaticBody2D

@onready var area_2d: Area2D = $Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	area_2d.body_entered.connect(on_body_entered)
	animation_player.play(&"spin", -1, randf_range(0.7, 1.3))

func _exit_tree() -> void:
	area_2d.body_entered.disconnect(on_body_entered)

func on_body_entered(body: Node2D) -> void:
	if body is Player:
		Globals.add_snowflake()
		queue_free()
