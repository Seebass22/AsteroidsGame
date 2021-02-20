extends "res://FlyingObject.gd"

var speed = 5
var rotationSpeed = 2
var friction = 1
var startPos = Vector2(100, 100)
var maxSpeed = 600

var velocity = Vector2()
var rotationDir = 0

const Bullet = preload("res://Bullet.tscn")

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
	if Input.is_action_just_pressed('shoot'):
		shoot()


func _physics_process(delta):
	get_input()
	rotation += rotationDir * rotationSpeed * delta
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.normal)
	apply_friction()
	constrain_position()
	limit_speed()


func limit_speed():
	velocity = velocity.clamped(maxSpeed)


func apply_friction():
	velocity -= velocity.normalized() * friction

func shoot():
	print('shoot')
	var bullet = Bullet.instance()
	bullet.position = position
	bullet.linear_velocity = velocity
	bullet.rotation = rotation
	get_parent().add_child(bullet)
