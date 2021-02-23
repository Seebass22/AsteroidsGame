extends KinematicBody2D

onready var xSize = get_viewport_rect().size.x
onready var ySize = get_viewport_rect().size.y

onready var left_border = 0
onready var right_border = xSize
onready var top_border = 0
onready var bottom_border = ySize

func set_wrap_margin(margin):
	left_border = 0 - margin
	right_border = xSize + margin
	top_border = 0 - margin
	bottom_border = ySize + margin


func constrain_position():
	if position.x > right_border:
		position.x = left_border

	if position.x < left_border:
		position.x = right_border

	if position.y > bottom_border:
		position.y = top_border

	if position.y < top_border:
		position.y = bottom_border
