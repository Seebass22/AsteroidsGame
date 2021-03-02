extends "res://src/FlyingObject.gd"

var speed = 5
var rotationSpeed = 2
var friction = 1
var startPos = Vector2(512, 300)
var maxSpeed = 600

var velocity = Vector2()
var rotationDir = 0

const Bullet = preload("res://Bullet.tscn")

func _ready():
	set_wrap_margin(15)
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
		thrust()
		emit_trail()
	else:
		stop_emitting_trail()
	if Input.is_action_just_pressed('shoot'):
		shoot()


func thrust():
	velocity += Vector2(0, -speed).rotated(rotation)
	if not $ThrustSound.playing:
		$ThrustSound.pitch_scale = (velocity.length() / 500) + 1
		$ThrustSound.play()


func emit_trail():
	$Trail.emitting = true


func stop_emitting_trail():
	$Trail.emitting = false


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
	$ShootSound.play()
	var bullet = Bullet.instance()
	bullet.position = position + Vector2(0, -25).rotated(rotation)
	bullet.velocity = velocity
	bullet.rotation = rotation
	get_parent().add_child(bullet)
	flash()


func flash():
	$bullet_flash.visible = true
	$bullet_flash/Timer.start()


func _on_bullet_flash_Timer_timeout():
	$bullet_flash.visible = false
