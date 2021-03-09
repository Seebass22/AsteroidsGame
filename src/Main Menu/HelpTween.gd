extends NinePatchRect

onready var target_position = rect_position
onready var tween_node = get_node("Tween")

func tween_in():
	rect_position = Vector2(rect_position.x, -600)
	tween_node.interpolate_property(self, "rect_position", rect_position, target_position, 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween_node.start()


func tween_out():
	var top_position = Vector2(rect_position.x, -600)
	tween_node.interpolate_property(self, "rect_position", rect_position, top_position, 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween_node.start()


func toggle_help():
	if $Tween.is_active():
		return

	if not visible:
		visible = true
		tween_in()
	else:
		tween_out()
		yield($Tween, "tween_completed")
		visible = false
