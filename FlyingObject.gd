extends KinematicBody2D

var xSize
var ySize

func _ready():
	xSize = get_viewport_rect().size.x
	ySize = get_viewport_rect().size.y

func constrain_position():
	if position.x > xSize:
		position.x = 0
	if position.x < 0:
		position.x = xSize
	if position.y > ySize:
		position.y = 0
	if position.y < 0:
		position.y = ySize
