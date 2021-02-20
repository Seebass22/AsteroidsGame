extends RigidBody2D

var speed = 500

func _ready():
	setBulletSpeed()

func setBulletSpeed():
	linear_velocity += Vector2(0, -speed).rotated(rotation)


func _on_Bullet_body_entered(body):
	if body.has_method('explode'):
		body.explode()
