extends Node

# score
var final_score = 0
var max_score = 6

# chord choices
var chord_group_names = ["triads+sus", "7th chords"]
var chord_groups = [["maj", "min", "dim", "aug", "sus2", "sus4"], ["7", "maj7", "min7", "dim7", "half-dim7", "min-maj7"]]
var group_index = 0

onready var current_chord_group = chord_group_names[group_index]

# settings
onready var starting_choices = chord_groups[group_index]
var round_length = 5
var rounds = 3


func add_round():
	rounds += 1


func subtract_round():
	if rounds > 1:
		rounds -= 1


func increase_round_legth():
	round_length += 1


func decrease_round_legth():
	if round_length > 1:
		round_length -= 1


func change_chord_groups():
	group_index = (group_index + 1) % chord_groups.size()

	starting_choices = chord_groups[group_index]
	current_chord_group = chord_group_names[group_index]

	return current_chord_group
