extends Node2D

const Asteroid = preload("res://Asteroid.tscn")

export (NodePath) var _score_path
export (NodePath) var _sound_path
onready var _sound = get_node(_sound_path)
onready var _score = get_node(_score_path)

var asteroids = []
var starting_choices = ["maj", "min", "dim", "aug", "sus2", "sus4"]
# var starting_choices = ["7", "maj7", "min7", "dim7", "half-dim7", "min-maj7"]

var choices
var root = 0
var current_chord
var score = 0
var max_score = 0
var replays_left

var rounds = 3
var max_replays = 3

func _process(delta):
	if Input.is_action_just_pressed("replay"):
		if replays_left > 0:
			_sound.setUpAndPlayChord(root, current_chord)
			replays_left -= 1


func _ready():
	GameEvents.connect("correct_asteroid", self, "_on_correct_asteroid_destroyed")
	GameEvents.connect("incorrect_asteroid", self, "_on_incorrect_asteroid_destroyed")
	initialize()
	set_up_game()


func initialize():
	Results.final_score = 0
	Results.max_score = rounds * starting_choices.size()
	max_score = starting_choices.size()


func set_up_game():
	choices = starting_choices.duplicate()

	choose_root()
	reset_replays_left()
	reset_score()

	# spawn asteroids
	for i in range(choices.size()):
		asteroids.append(Asteroid.instance())
		asteroids[i].position = Vector2(i * 150, 100)
		asteroids[i].label_text = choices[i]
		add_child(asteroids[i])

	choose_correct_asteroid()

	_sound.setUpAndPlayChord(root, current_chord)
	update_score()


func choose_root():
	randomize()
	root = (randi() % 20) - 10


func reset_score():
	score = 0


func choose_correct_asteroid():
	randomize()
	var correct_index = randi() %  choices.size()
	asteroids[correct_index].is_correct = true
	current_chord = choices[correct_index]
	return correct_index


func update_score():
	_score.set_text("%d/%d" % [score, max_score])

	if is_round_over():
		finish_round()


func is_round_over():
	return choices.size() == 0


func finish_round():
		Results.final_score += score
		yield(get_tree().create_timer(2.0), "timeout")

		rounds -= 1
		if rounds > 0:
			set_up_game()
		else:
			get_tree().change_scene("res://Game Over.tscn")


func _on_correct_asteroid_destroyed(type_destroyed):
	score += 1
	next_chord(type_destroyed)
	update_score()


func _on_incorrect_asteroid_destroyed(type_destroyed):
	next_chord(type_destroyed)


func next_chord(type_destroyed):
	reset_replays_left()
	remove_destroyed_chord(type_destroyed)

	if is_round_over():
		return

	var correct_index = choose_correct_asteroid()

	yield(get_tree().create_timer(1.0), "timeout")
	if correct_index < choices.size():
		_sound.setUpAndPlayChord(root, current_chord)


func remove_destroyed_chord(type):
	var rm_index = choices.find(type)
	asteroids.remove(rm_index)
	choices.remove(rm_index)


func reset_replays_left():
	replays_left = max_replays
