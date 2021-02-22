extends Node2D

const Asteroid = preload("res://Asteroid.tscn")

export (NodePath) var _sound_path
onready var _sound = get_node(_sound_path)

var asteroids = []

func _ready():
	set_up_game()


func set_up_game():
	asteroids.append(Asteroid.instance())
	asteroids.append(Asteroid.instance())
	asteroids.append(Asteroid.instance())
	asteroids.append(Asteroid.instance())

	asteroids[0].is_correct = true
	asteroids[0].label_text = "adsjfjlkfsd"

	for i in range(4):
		asteroids[i].position = Vector2(i * 150, 100)
		add_child(asteroids[i])
