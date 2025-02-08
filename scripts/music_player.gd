extends Node

@export var music_player: AudioStreamPlayer
@export var sfx_player: AudioStreamPlayer2D

var current_music: AudioStream

func _ready() -> void:
	music_player.stop()
	sfx_player.stop()

func play_music(music: AudioStream) -> void:
	if music == current_music:
		return

	var db = music_player.volume_db
	await get_tree().create_tween().tween_property(music_player, "volume_db", -100, 0.25).finished
	music_player.stop()
	music_player.stream = music
	music_player.play()
	await get_tree().create_tween().tween_property(music_player, "volume_db", db, 0.25).finished
	current_music = music

func play_sfx(sfx: AudioStream, at: Vector2) -> void:
	var temp = sfx_player.duplicate()
	get_tree().root.add_child(temp)
	temp.global_position = at
	temp.stream = sfx
	temp.play()

	get_tree().create_timer(8).timeout.connect(temp.queue_free)
