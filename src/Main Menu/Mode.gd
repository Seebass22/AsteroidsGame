extends HBoxContainer

onready var labelnode = get_node("ModeButton/label") 

func _ready():
	labelnode.text = Settings.current_chord_group


func _on_ModeButton_button_up():
	var current_type = Settings.change_chord_groups()
	labelnode.text = current_type
