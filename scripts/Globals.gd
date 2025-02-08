extends Node

var player: Player = null
var snowflakes: int = 0
var snowflakes_this_level: int = 0
var hits: int = 0
var dies: int = 0

signal snowflake_added(snowflakes: int)

signal level_changed
signal wall_hit(hits: int)
signal died(dies: int)

func add_snowflake() -> void:
	snowflakes += 1
	snowflakes_this_level += 1
	snowflake_added.emit(snowflakes)

func lock_controls() -> void:
	player.input.disable_inputs()

func unlock_controls() -> void:
	player.input.enable_inputs()

func new_level() -> void:
	snowflakes_this_level = 0
	level_changed.emit()

func new_hit() -> void:
	hits += 1
	wall_hit.emit(hits)

func new_die() -> void:
	snowflakes -= snowflakes_this_level
	snowflakes_this_level = 0
	dies += 1
	died.emit(dies)

func print_log(message: String) -> void:
	print_rich("[color=green]GLOBALS[/color]: " + message)
