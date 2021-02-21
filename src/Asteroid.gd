extends "res://src/FlyingObject.gd"

var speed = 250
var minSpeed = 150
var maxSpeed = 350

var velocity = Vector2()

func _ready():
	randomize()
	rotation = randi() % 360
	speed = rand_range(minSpeed, maxSpeed)
	velocity = Vector2(0, 1).rotated(deg2rad(rotation)) * speed


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.normal)
	constrain_position()


func explode():
	$ExplosionSound.play()
	$Sprite.visible = false
	$CollisionPolygon2D.set_deferred('disabled', true)
	yield($ExplosionSound, 'finished')
	queue_free()
