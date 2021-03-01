extends Node2D

class_name TweenLib

static func tween_in_from_left(object):
	var tween_node = object.get_node("Tween")
	var target_position = object.rect_position

	object.rect_position = Vector2(-250, target_position.y)
	var starting_position = object.rect_position

	tween_node.interpolate_property(object, "rect_position", starting_position, target_position, 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween_node.start()
