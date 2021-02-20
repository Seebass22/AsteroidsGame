extends "res://FlyingObject.gd"

var speed = 800
var velocity = Vector2()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method('explode'):
			collision.collider.explode()
			queue_free()
	constrain_position()


func _ready():
	setBulletSpeed()


func setBulletSpeed():
	velocity += Vector2(0, -speed).rotated(rotation)


func _on_Bullet_body_entered(body):
	if body.has_method('explode'):
		body.explode()


func _on_LiveTimer_timeout():
	queue_free()
