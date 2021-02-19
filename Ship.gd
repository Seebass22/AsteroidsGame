extends KinematicBody2D

var speed = 5
var rotationSpeed = 2
var friction = 1
var startPos = Vector2(100, 100)
var maxSpeed = 600

var velocity = Vector2()
var rotationDir = 0

var xSize
var ySize


func _ready():
	position = startPos
	xSize = get_viewport_rect().size.x
	ySize = get_viewport_rect().size.y


func get_input():
	rotationDir = 0
	if Input.is_action_pressed('turn_right'):
		rotationDir += 1
	if Input.is_action_pressed('turn_left'):
		rotationDir -= 1
	if Input.is_action_pressed('forward'):
		velocity += Vector2(0, -speed).rotated(rotation)


func _physics_process(delta):
	get_input()
	rotation += rotationDir * rotationSpeed * delta
	velocity = move_and_slide(velocity)
	apply_friction()
	constrain_position()
	limit_speed()


func constrain_position():
	if position.x > xSize:
		position.x = 0
	if position.x < 0:
		position.x = xSize
	if position.y > ySize:
		position.y = 0
	if position.y < 0:
		position.y = ySize


func limit_speed():
	velocity = velocity.clamped(maxSpeed)


func apply_friction():
	velocity -= velocity.normalized() * friction
