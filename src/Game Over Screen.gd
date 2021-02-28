extends Node2D

export (NodePath) var _score_path
onready var _score = get_node(_score_path)

func _ready():
	var percentage = (Results.final_score / Results.max_score as float) * 100
	_score.set_text("%d / %d (%d%%)" % [Results.final_score, Results.max_score, percentage])


func _on_Restart_button_up():
	get_tree().change_scene("res://Game.tscn")
