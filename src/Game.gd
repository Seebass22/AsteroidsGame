extends Node2D

const Asteroid = preload("res://Asteroid.tscn")

export (NodePath) var _score_path
export (NodePath) var _sound_path
onready var _sound = get_node(_sound_path)
onready var _score = get_node(_score_path)

var asteroids = []
var choices = ["maj", "min", "dim", "aug", "sus2", "sus4"]
# var choices = ["7", "maj7", "min7", "dim7", "half-dim7", "min-maj7"]
var root = 0
var score = 0
var max_score = 0

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func _ready():
	GameEvents.connect("correct_asteroid", self, "_on_correct_asteroid_destroyed")
	GameEvents.connect("incorrect_asteroid", self, "_on_incorrect_asteroid_destroyed")
	set_up_game()


func set_up_game():
	# choose correct asteroid, root note
	randomize()
	var correct_index = randi() %  choices.size()
	randomize()
	root = (randi() % 20) - 10

	max_score = choices.size()
	Results.max_score = max_score

	# spawn asteroids
	for i in range(choices.size()):
		asteroids.append(Asteroid.instance())

		asteroids[i].position = Vector2(i * 150, 100)
		asteroids[i].label_text = choices[i]
		if i == correct_index:
			asteroids[i].is_correct = true

		add_child(asteroids[i])

	_sound.setUpAndPlayChord(root, choices[correct_index])
	update_score()


func update_score():
	_score.set_text("%d/%d" % [score, max_score])

	if choices.size() == 0:
		Results.final_score = score
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://Game Over.tscn")


func _on_correct_asteroid_destroyed(type_destroyed):
	score += 1
	nextChord(type_destroyed)
	update_score()


func _on_incorrect_asteroid_destroyed(type_destroyed):
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
		_sound.setUpAndPlayChord(root, choices[correct_index])
