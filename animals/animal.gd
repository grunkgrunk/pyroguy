extends KinematicBody2D

var dir = Vector2()
var dead = false
var move_speed = 20
var burns = false
export(PackedScene) var expl
# Called when the node enters the scene tree for the first time.
func _ready():
	$body.connect("dead", self, "on_dead")
	$body.connect("hit", self, "on_hit")
	
	dir = r()
	$timer.connect("timeout", self, "on_timeout")
	on_timeout()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		return
	$anim.modulate = Color(0,0,0)
	move_and_collide(dir * move_speed * delta)
	

func on_timeout():
	if dead:
		return
	$timer.wait_time = rand_range(1, 1.5)
	if rand_range(0,1) > 0.7 and not burns:
		if abs(dir.x) > abs(dir.y):
			$anim.animation = "eat_" + choice(dir.x, "left", "right")
		else:
			$anim.animation = "eat_" + choice(dir.x, "up", "down")
			
		dir = Vector2()
	else:
		var d = r()
		if abs(d.x) > abs(d.y):
			$anim.animation = "walk_" + choice(d.x, "left", "right")
		else:
			$anim.animation = "walk_" + choice(d.y, "up", "down")
		dir = d
	

func r():
	return Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()

func choice(x, a, b):
	if x < 0:
		return a
	else:
		return b

func on_burns():
		
	burns = true 
	move_speed = 70
	$anim.speed_scale = 4
func on_dead():
	dead = true
	$anim.stop()
func on_hit():
	pass
