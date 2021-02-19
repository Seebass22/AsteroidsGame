extends "res://FlyingObject.gd"

var speed = 250
var minSpeed = 150
var maxSpeed = 350

var startPos = Vector2(800, 800)
var velocity = Vector2()

func _ready():
	randomize()
	rotation = randi() % 360
	speed = rand_range(minSpeed, maxSpeed)
	position = startPos
	velocity = Vector2(0, 1).rotated(deg2rad(rotation)) * speed


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.normal)
	constrain_position()
