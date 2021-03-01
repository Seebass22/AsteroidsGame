extends Node2D

export (NodePath) var _quit_path
onready var _quit_button = get_node(_quit_path)

func _ready():
	if OS.get_name() == "HTML5":
		_quit_button.visible = false


func _on_PlayButton_button_up():
	get_tree().change_scene("res://Game.tscn")


func _on_HelpButton_button_up():
	$Help.visible = not $Help.visible


func _on_QuitButton_button_up():
	get_tree().quit()
