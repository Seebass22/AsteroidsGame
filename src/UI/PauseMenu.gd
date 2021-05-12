extends Control


func _ready():
	self.visible = false

	if OS.get_name() == "HTML5":
		$VBoxContainer/Buttons/quit.visible = false


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()


func toggle_pause():
	if get_tree().paused:
		self.visible = false
		get_tree().paused = false
	else:
		self.visible = true
		get_tree().paused = true


func _on_Continue_button_up():
	toggle_pause()


func _on_menu_button_up():
	toggle_pause()
	get_tree().change_scene("res://Main Menu.tscn")


func _on_quit_button_up():
	get_tree().quit()


func _on_PauseButton_button_up():
	toggle_pause()
