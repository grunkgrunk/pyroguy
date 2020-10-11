extends KinematicBody2D

export(PackedScene) var particle
signal shooting

export(int) var player_num

var last_dir = Vector2(1,0)
var move_speed = 200
var gun_range = 50
var damage = 1
var health = 2

onready var gun = $gun

# Called when the node enters the scene tree for the first time.
func _ready():
	var p = Vector2()
	if player_num == 1:
		p = Vector2(143, 223)
	if player_num == 2:
		p = Vector2(143 - 16, 223) 
	
	var r = $Sprite.region_rect
	$Sprite.region_rect = Rect2(p, Vector2(16,16))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$fire.global_position = global_position
	var vel = Vector2()
	if Input.is_action_pressed("left_" + str(player_num)):
		vel.x = -1
	if Input.is_action_pressed("right_" + str(player_num)):
		vel.x = 1
	if Input.is_action_pressed("up_" + str(player_num)):
		vel.y = -1
	if Input.is_action_pressed("down_" + str(player_num)):
		vel.y = 1
	vel = vel.normalized()
	if vel.length() > 0:
		last_dir = vel
	
	$Sprite.flip_h = last_dir.x < 0
	$fire.emitting(false)
	if Input.is_action_pressed("shoot_" + str(player_num)):
		$fire.set_dir(last_dir)
		$fire.emitting(true)
		#var p = particle.instance()
		#p.position = global_position
		#p.standard()
		#var a = last_dir.angle()
		#var spread = 0.2
		emit_signal("shooting")
		#var na = a + rand_range(-spread, spread)
		#p.vel = Vector2(cos(na), sin(na)) * rand_range(150, 200) 
		#$shots.add_child(p)
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
