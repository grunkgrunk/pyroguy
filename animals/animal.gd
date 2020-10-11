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
	$body.connect("burns", self, "on_burns")
	
	dir = r()
	$timer.connect("timeout", self, "on_timeout")
	on_timeout()
	$normal.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		return
	
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
	$auch.play()
	$normal.stop()
	burns = true 
	move_speed = 70
	$anim.speed_scale = 4
func on_dead(a):
	dead = true
	$normal.stop()
	$auch.stop()
	$anim.stop()
func on_hit():
	pass
