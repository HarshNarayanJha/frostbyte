extends Node2D

@export var win_title: Label
@export var win_text: Label
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

func _ready() -> void:
	if Globals.snowflakes >= 12 and Globals.game_seconds <= 600:
		win_title.text ="Congrats"
		win_text.text = "You saved\nChristmas"
	else:
		win_title.text ="Too Bad"
		win_text.text = "You couldn't save\nChristmas"
		cpu_particles_2d.emitting = false
