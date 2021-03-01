extends Node2D

export (NodePath) var _score_path
export (NodePath) var _quit_path
onready var _score = get_node(_score_path)
onready var _quit_button = get_node(_quit_path)

func _ready():
	var percentage = (Results.final_score / Results.max_score as float) * 100
	_score.set_text("%d / %d (%d%%)" % [Results.final_score, Results.max_score, percentage])

	if OS.get_name() == "HTML5":
		_quit_button.visible = false


func _on_Restart_button_up():
	get_tree().change_scene("res://Game.tscn")


func _on_Menu_button_up():
	get_tree().change_scene("res://Main Menu.tscn")


func _on_Quit_button_up():
	get_tree().quit()
