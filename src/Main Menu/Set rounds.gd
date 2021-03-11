extends VBoxContainer

onready var _label = get_node("UI/count")

func _ready():
	update_label()


func update_label():
	_label.text = str(Settings.rounds)


func _on_add_pressed():
	Settings.add_round()
	update_label()


func _on_subtract_pressed():
	Settings.subtract_round()
	update_label()
