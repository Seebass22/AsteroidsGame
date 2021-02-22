extends "res://src/FlyingObject.gd"

var label_text = "Maj"
var is_correct: bool = false
var speed = 250
var minSpeed = 150
var maxSpeed = 350

var velocity = Vector2()

func _ready():
	randomize()
	rotation = randi() % 360
	speed = rand_range(minSpeed, maxSpeed)
	velocity = Vector2(0, 1).rotated(deg2rad(rotation)) * speed
	$Label.text = label_text


func _process(delta): 
	$Label.set_rotation(-rotation)


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.normal)
	constrain_position()


func explode():
	if is_correct:
		GameEvents.emit_signal("correct_asteroid", label_text)
	else:
		GameEvents.emit_signal("incorrect_asteroid", label_text)

	$ExplosionSound.play()
	$Sprite.visible = false
	$Label.text = ""
	$CollisionPolygon2D.set_deferred('disabled', true)
	yield($ExplosionSound, 'finished')
	queue_free()
