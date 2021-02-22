extends Node2D

const Asteroid = preload("res://Asteroid.tscn")

export (NodePath) var _sound_path
onready var _sound = get_node(_sound_path)

var asteroids = []

func _ready():
	GameEvents.connect("correct_asteroid", self, "_on_correct_asteroid_destroyed")
	GameEvents.connect("incorrect_asteroid", self, "_on_incorrect_asteroid_destroyed")
	set_up_game()


func set_up_game():
	var choices = ["Maj", "Min", "Dim", "Aug", "sus2", "sus4"]
	randomize()
	var correct_index = randi() %  choices.size()

	for i in range(choices.size()):
		asteroids.append(Asteroid.instance())

		asteroids[i].position = Vector2(i * 150, 100)
		asteroids[i].label_text = choices[i]
		if i == correct_index:
			asteroids[i].is_correct = true

		add_child(asteroids[i])


func _on_correct_asteroid_destroyed():
	print("correct")


func _on_incorrect_asteroid_destroyed():
	print("incorrect")
