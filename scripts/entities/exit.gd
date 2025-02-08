class_name Exit extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var exit_timer: Timer = $ExitTimer

@export var contact_areas: Array[Area2D]
@export var initial_rotation_speed := 2
@export var slowdown_speed := 2
@export var next_level_scene: PackedScene
@export var level_complete_jingle: AudioStream
@export var next_transition := "scribbles"

var contacts_done := 0
var rotation_speed := 0.0

func _ready() -> void:
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)
	exit_timer.timeout.connect(next_level)

	rotation_speed = initial_rotation_speed
	for i in contact_areas.size():
		contact_areas[i].body_entered.connect(check_player_in_contact.bind(i, true))
		contact_areas[i].body_exited.connect(check_player_in_contact.bind(i, false))

	animation_player.play(&"start_blink")

func _exit_tree() -> void:
	self.body_entered.disconnect(on_body_entered)

func _process(delta: float) -> void:
	self.rotate(rotation_speed * delta)

	match contacts_done:
		0:
			rotation_speed = move_toward(rotation_speed, initial_rotation_speed, slowdown_speed * delta)
		1:
			rotation_speed = move_toward(rotation_speed, 3 * initial_rotation_speed / 4, slowdown_speed * delta)
		2:
			rotation_speed = move_toward(rotation_speed, initial_rotation_speed / 2, slowdown_speed * delta)
		3:
			rotation_speed = move_toward(rotation_speed, initial_rotation_speed / 4, slowdown_speed * delta)
		4:
			rotation_speed = move_toward(rotation_speed, 0, slowdown_speed * delta)

	if is_zero_approx(rotation_speed) and exit_timer.is_stopped():
		exit_timer.start()
	elif not is_zero_approx(rotation_speed) and not exit_timer.is_stopped():
		exit_timer.stop()


func on_body_entered(body: Node2D) -> void:
	pass

func on_body_exited(body: Node2D) -> void:
	if body is Player:
		contacts_done = 0

func next_level() -> void:
	rotation_speed = -200
	contacts_done = 50
	MusicPlayer.play_sfx(level_complete_jingle, global_position)
	SceneManager.change_scene(next_level_scene, {"pattern": next_transition, "wait_time": 1, "speed": 1})
	Globals.new_level()

func check_player_in_contact(body: Node2D, index: int, entered: bool) -> void:
	if body is not Player:
		return
	contacts_done += 1 if entered else -1
