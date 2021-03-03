extends Node

var final_score = 0
var max_score = 6

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
