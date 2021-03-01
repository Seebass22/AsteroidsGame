extends VBoxContainer

func _ready():
	var tween_node = get_node("Tween")
	var target_position = rect_position
	rect_position = Vector2(-250, rect_position.y)
	tween_node.interpolate_property(self, "rect_position", rect_position, target_position, 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween_node.start()
