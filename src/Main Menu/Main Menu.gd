extends Node2D

export (NodePath) var _quit_path
onready var _quit_button = get_node(_quit_path)

onready var setup_position = $Setup.rect_position

func _ready():
	if OS.get_name() == "HTML5":
		_quit_button.visible = false

	TweenLib.tween_in_from_left($Buttons, 1)
	TweenLib.tween_in_from_left($Title, 1.25)


func _on_PlayButton_button_up():
	get_tree().change_scene("res://Game.tscn")


func _on_HelpButton_button_up():
	$Help.visible = not $Help.visible
	$Help.tween_in()


func _on_QuitButton_button_up():
	get_tree().quit()


func _on_SetupButton_button_up():
	$Setup.rect_position = setup_position
	$Setup.visible = not $Setup.visible
	TweenLib.tween_in_from_left($Setup, 0.8)
