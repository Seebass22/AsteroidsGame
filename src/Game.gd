extends Node2D

export (NodePath) var _sound_path
onready var _sound = get_node(_sound_path)

func _ready():
	_sound.setUpAndPlayChord(0, _sound.chordType.SUS4)
	yield(get_tree().create_timer(5.0), "timeout")
	_sound.play_I_IV_V_I()
