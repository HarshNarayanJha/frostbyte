class_name HelpCreditsController extends Node

@export var back_button: Button
@export var main_menu_path: String
@export var scene_music: AudioStream

func _ready() -> void:
	back_button.pressed.connect(go_back)
	MusicPlayer.play_music(scene_music)

func _exit_tree() -> void:
	back_button.pressed.disconnect(go_back)

func go_back() -> void:
	SceneManager.change_scene(main_menu_path, {"pattern": "curtains", "color": Color.WHITE, "wait_time": 1, "speed": 1})
