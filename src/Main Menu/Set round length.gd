extends VBoxContainer

onready var _label = get_node("UI/count")

func _ready():
	update_label()


func update_label():
	_label.text = str(Settings.round_length)


func _on_add_pressed():
	Settings.increase_round_legth()
	update_label()


func _on_subtract_pressed():
	Settings.decrease_round_legth()
	update_label()
