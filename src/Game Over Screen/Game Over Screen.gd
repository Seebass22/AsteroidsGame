extends Node2D

export (NodePath) var _score_path
export (NodePath) var _quit_path
onready var _score = get_node(_score_path)
onready var _quit_button = get_node(_quit_path)

func _ready():
	set_score_label()

	if OS.get_name() == "HTML5":
		_quit_button.visible = false
	
	TweenLib.tween_in_from_left($Menu, 1)


func set_score_label():
	var percentage = (Results.final_score / Results.max_score as float) * 100
	_score.set_text("%d / %d (%d%%)" % [Results.final_score, Results.max_score, percentage])


func _on_Restart_button_up():
	get_tree().change_scene("res://Game.tscn")


func _on_Menu_button_up():
	get_tree().change_scene("res://Main Menu.tscn")


func _on_Quit_button_up():
	get_tree().quit()
