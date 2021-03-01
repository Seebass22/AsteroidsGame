extends "res://src/FlyingObject.gd"

export (NodePath) var _text_path
onready var label = get_node(_text_path)

var label_text = "Maj"
var is_correct: bool = false
var speed = 250
var minSpeed = 150
var maxSpeed = 350

var velocity = Vector2()

func _ready():
	set_wrap_margin(20)
	randomize()
	rotation = randi() % 360
	speed = rand_range(minSpeed, maxSpeed)
	velocity = Vector2(0, 1).rotated(deg2rad(rotation)) * speed
	label.text = label_text


func _process(delta): 
	$LabelPivot.set_rotation(-rotation)


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.normal)
	constrain_position()
	constrain_velocity()


func constrain_velocity():
	if velocity.length() < 100:
		velocity = velocity.normalized() * 15


func explode():
	if is_correct:
		GameEvents.emit_signal("correct_asteroid", label_text)
	else:
		GameEvents.emit_signal("incorrect_asteroid", label_text)

	$ExplosionSound.play()
	label.text = ""
	$Sprite.animation = "explode"
	$ExplosionTimer.start()
	$CollisionPolygon2D.set_deferred('disabled', true)
	yield($ExplosionSound, 'finished')
	queue_free()


func _on_ExplosionTimer_timeout():
	$Sprite.visible = false
