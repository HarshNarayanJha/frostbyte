class_name MainMenuController extends Node

@export var main_music_theme: AudioStream
@export var play_button: Button
@export var help_button: Button
@export var credits_button: Button
@export var exit_button: Button

@export var level0: PackedScene
@export var help_scene: PackedScene
@export var credits_scene: PackedScene

func _ready() -> void:
	play_button.pressed.connect(start_game)
	help_button.pressed.connect(start_help)
	credits_button.pressed.connect(start_credits)
	exit_button.pressed.connect(get_tree().quit)

	MusicPlayer.play_music(main_music_theme)

func _exit_tree() -> void:
	play_button.pressed.disconnect(start_game)
	help_button.pressed.disconnect(start_help)
	credits_button.pressed.disconnect(start_credits)
	exit_button.pressed.disconnect(get_tree().quit)


func start_game() -> void:
	SceneManager.change_scene(level0, {"pattern": "squares", "color": Color.BLACK, "wait_time": 0.8, "speed": 1})

func start_help() -> void:
	SceneManager.change_scene(help_scene, {"pattern": "circle", "color": Color.WHITE, "wait_time": 0.8, "speed": 1})

func start_credits() -> void:
	SceneManager.change_scene(credits_scene, {"pattern": "curtains", "color": Color.WHITE, "wait_time": 0.8, "speed": 1})
