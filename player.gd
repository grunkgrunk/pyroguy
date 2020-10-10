extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PackedScene) var particle

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
	if Input.is_action_pressed("shoot"):
		var p = particle.instance()
		p.position = global_position
		p.standard()
		var a = last_dir.angle()
		var spread = 0.2
		$cam.add_trauma(0.1)
		var na = a + rand_range(-spread, spread)
		p.vel = Vector2(cos(na), sin(na)) * rand_range(150, 200) 
		$shots.add_child(p)
		$ray.cast_to = last_dir * gun_range
		var r = $ray.get_collider()
		if r != null:
			if r.is_in_group("can_ignite"):
				r.hit(damage, delta)
		
	
	move_and_slide(vel * move_speed)
	
func hit(dmg, delta):
	health -= dmg * delta
	if health < 0:
		print("player is ded")
