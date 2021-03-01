extends Node2D

func _on_PlayButton_button_up():
	get_tree().change_scene("res://Game.tscn")


func _on_HelpButton_button_up():
	$Help.visible = not $Help.visible


func _on_QuitButton_button_up():
	if OS.get_name() != "HTML5":
		get_tree().quit()
