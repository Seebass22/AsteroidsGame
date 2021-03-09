extends Node2D

class_name TweenLib

static func tween_in_from_left(object, time, trans_type=Tween.TRANS_BOUNCE):
	var tween_node = object.get_node("Tween")
	var target_position = object.rect_position

	if tween_node.is_active():
		return

	object.rect_position = Vector2(-250, target_position.y)
	var starting_position = object.rect_position

	object.visible = true
	tween_node.interpolate_property(object, "rect_position", starting_position, target_position, time, trans_type, Tween.EASE_OUT)
	tween_node.start()


static func tween_out_to_left(object, time):
	var tween_node = object.get_node("Tween")
	var target_position = Vector2(-250, object.rect_position.y)

	if tween_node.is_active():
		return

	var starting_position = object.rect_position

	tween_node.interpolate_property(object, "rect_position", starting_position, target_position, time, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween_node.start()

	yield(tween_node, "tween_completed")
	object.rect_position = starting_position
	object.visible = false


static func toggle_tween(object, time, trans_type=Tween.TRANS_BOUNCE):
	if object.visible:
		tween_out_to_left(object, 0.5)
	else:
		tween_in_from_left(object, time, trans_type)
