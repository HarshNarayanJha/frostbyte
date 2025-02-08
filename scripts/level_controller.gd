extends Node

@export var camera: PhantomCamera2D
@export var level_music: AudioStream

func _ready() -> void:
	MusicPlayer.play_music(level_music)
