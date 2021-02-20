extends "res://FlyingObject.gd"

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
	set_collision_layer_bit(2, false)
	set_collision_mask_bit(1, false)
	set_collision_mask_bit(2, false)
	set_collision_mask_bit(3, false)
	yield($ExplosionSound, 'finished')
	queue_free()
