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
var asteroids_left_in_round
var game_over = false

var round_length = 6
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
	reset_asteroids_left_in_round()

	# spawn asteroids
	for i in range(choices.size()):
		var type = choices[i]
		var new_asteroid = spawn_asteroid(type)
		asteroids.append(new_asteroid)
		add_child(asteroids[i])

	choose_correct_asteroid()

	_sound.setUpAndPlayChord(root, current_chord)
	update_score()


func choose_root():
	randomize()
	root = (randi() % 20) - 10


func reset_replays_left():
	replays_left = max_replays


func reset_score():
	score = 0


func reset_asteroids_left_in_round():
	print('reset')
	asteroids_left_in_round = round_length


func choose_correct_asteroid():
	for i in asteroids.size():
		asteroids[i].is_correct = false

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
	return asteroids_left_in_round < 1


func finish_round():
		Results.final_score += score

		rounds -= 1
		if rounds > 0:
			set_up_game()
		else:
			game_over = true
			yield(get_tree().create_timer(2.0), "timeout")
			get_tree().change_scene("res://Game Over.tscn")


func _on_correct_asteroid_destroyed(type_destroyed):
	if game_over:
		return
	asteroids_left_in_round -= 1
	score += 1
	check_round_over()
	next_chord(type_destroyed)
	update_score()


func _on_incorrect_asteroid_destroyed(type_destroyed):
	if game_over:
		return
	asteroids_left_in_round -= 1
	check_round_over()
	next_chord(type_destroyed)


func check_round_over():
	if is_round_over():
		finish_round()


func next_chord(type_destroyed):
	print(asteroids_left_in_round)
	reset_replays_left()
	replace_destroyed_asteroid(type_destroyed)

	if is_round_over():
		return

	var correct_index = choose_correct_asteroid()

	yield(get_tree().create_timer(1.0), "timeout")
	if correct_index < choices.size():
		_sound.setUpAndPlayChord(root, current_chord)


func replace_destroyed_asteroid(type):
	var index = choices.find(type)

	var new_asteroid = spawn_asteroid(type)

	asteroids[index] = new_asteroid
	add_child(new_asteroid)


func spawn_asteroid(type):
	randomize()
	var x_pos = randi() % 1024
	var y_pos = (randi() % 2) * 600

	var new_asteroid = Asteroid.instance()
	new_asteroid.position = Vector2(x_pos, y_pos)
	new_asteroid.label_text = type

	return new_asteroid
