extends Node2D

const Asteroid = preload("res://Asteroid.tscn")

export (NodePath) var _sound_path
onready var _sound = get_node(_sound_path)

var asteroids = []
var choices = ["maj", "min", "dim", "aug", "sus2", "sus4"]

func _ready():
	GameEvents.connect("correct_asteroid", self, "_on_correct_asteroid_destroyed")
	GameEvents.connect("incorrect_asteroid", self, "_on_incorrect_asteroid_destroyed")
	set_up_game()


func set_up_game():
	randomize()
	var correct_index = randi() %  choices.size()

	for i in range(choices.size()):
		asteroids.append(Asteroid.instance())

		asteroids[i].position = Vector2(i * 150, 100)
		asteroids[i].label_text = choices[i]
		if i == correct_index:
			asteroids[i].is_correct = true

		add_child(asteroids[i])

	_sound.setUpAndPlayChord(0, choices[correct_index])


func _on_correct_asteroid_destroyed(type_destroyed):
	print("correct")
	nextChord(type_destroyed)


func _on_incorrect_asteroid_destroyed(type_destroyed):
	print("incorrect")
	nextChord(type_destroyed)


func nextChord(type_destroyed):
	var rm_index = choices.find(type_destroyed)
	asteroids.remove(rm_index)
	choices.remove(rm_index)

	if asteroids.size() == 0:
		return

	randomize()
	var correct_index = randi() %  choices.size()
	asteroids[correct_index].is_correct = true

	yield(get_tree().create_timer(1.0), "timeout")
	if correct_index < choices.size():
		_sound.setUpAndPlayChord(0, choices[correct_index])
