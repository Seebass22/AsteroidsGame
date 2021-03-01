extends NinePatchRect

onready var target_position = rect_position
onready var tween_node = get_node("Tween")

func tween_in():
	rect_position = Vector2(rect_position.x, -600)
	tween_node.interpolate_property(self, "rect_position", rect_position, target_position, 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween_node.start()
