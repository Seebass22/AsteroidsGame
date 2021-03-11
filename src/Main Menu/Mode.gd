extends HBoxContainer

onready var labelnode = get_node("ModeButton/label") 

func _ready():
	labelnode.text = Results.current_chord_group


func _on_ModeButton_button_up():
	var current_type = Results.change_chord_groups()
	labelnode.text = current_type
