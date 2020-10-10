extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var last_dir = Vector2(1,0)
var move_speed = 50
var gun_range = 50
var damage = 1
var health = 2

onready var gun = $gun

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var vel = Vector2()
	if Input.is_action_pressed("ui_left"):
		vel.x = -1
	if Input.is_action_pressed("ui_right"):
		vel.x = 1
	if Input.is_action_pressed("ui_up"):
		vel.y = -1
	if Input.is_action_pressed("ui_down"):
		vel.y = 1
	vel = vel.normalized()
	if vel.length() > 0:
		last_dir = vel
	$gun.emitting = false
	if Input.is_action_pressed("shoot"):
		$gun.emitting = true
		$ray.cast_to = last_dir * gun_range
		var r = $ray.get_collider()
		if r != null:
			print(r)
			if r.is_in_group("can_ignite"):
				r.hit(damage, delta)
		
		gun.process_material.direction = Vector3(last_dir.x, last_dir.y, 0)
	
	move_and_slide(vel * move_speed)
	
	
	
func hit(dmg, delta):
	health -= dmg * delta
	if health < 0:
		print("player is ded")
