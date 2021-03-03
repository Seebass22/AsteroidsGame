extends Node2D

export (NodePath) var _quit_path
onready var _quit_button = get_node(_quit_path)
export (NodePath) var _round_label_path
onready var _round_label = get_node(_round_label_path)

func _ready():
	if OS.get_name() == "HTML5":
		_quit_button.visible = false

	TweenLib.tween_in_from_left($Buttons, 1)
	TweenLib.tween_in_from_left($Title, 1.25)
	update_rounds_label()


func update_rounds_label():
	_round_label.text = str(Results.round_length)


func _on_PlayButton_button_up():
	get_tree().change_scene("res://Game.tscn")


func _on_HelpButton_button_up():
	$Help.visible = not $Help.visible
	$Help.tween_in()


func _on_QuitButton_button_up():
	get_tree().quit()


func _on_add_round_pressed():
	Results.increase_round_legth()
	update_rounds_label()


func _on_subtract_round_pressed():
	Results.decrease_round_legth()
	update_rounds_label()
