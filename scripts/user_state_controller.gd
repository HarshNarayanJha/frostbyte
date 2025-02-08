extends Node

@export var snowflakes_count: Label
@export var hits_count: Label
@export var die_count: Label
@export var game_timer: Label

var time_elapsed := 0.0

func _ready() -> void:
	Globals.snowflake_added.connect(update_snowflakes)
	Globals.wall_hit.connect(update_hits)
	Globals.died.connect(update_dies)

	update_snowflakes(Globals.snowflakes)
	update_hits(Globals.hits)
	update_dies(Globals.dies)

	time_elapsed = Globals.game_seconds


func _exit_tree() -> void:
	Globals.snowflake_added.disconnect(update_snowflakes)
	Globals.wall_hit.disconnect(update_hits)
	Globals.died.disconnect(update_dies)

	Globals.game_seconds = time_elapsed

func update_snowflakes(snowflakes: int) -> void:
	snowflakes_count.text = str(snowflakes).pad_zeros(2)

func update_hits(hits: int) -> void:
	hits_count.text = str(hits).pad_zeros(2)

func update_dies(dies: int) -> void:
	die_count.text = str(dies).pad_zeros(2)

func _process(delta : float) -> void:
	time_elapsed += delta
	game_timer.text = _format_seconds(time_elapsed)

func _format_seconds(time : float) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)

	return "%02d:%02d:%02d" % [0, minutes, seconds]
