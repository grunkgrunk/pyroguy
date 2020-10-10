extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector2()
var rspd = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	playing = true


func initial():
	animation = "init"
	

func standard():
	animation = "continuous"
	rspd = rand_range(-1,1)
	speed_scale = rand_range(3, 4)
	flip_h = num_to_bool(rand_range(0,1))
	flip_v = num_to_bool(rand_range(0,1))
	var s = rand_range(0.1, 0.6)
	scale = Vector2(s, s)
	var a = rand_range(0, 2*PI)
	position += Vector2(cos(a), sin(a)) * rand_range(0, 10)
	rotation = rand_range(0, 2*PI)

func num_to_bool(a):
	return a < 0.5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not animation == "init":
		position += vel * delta
	#rotation += rspd


func _on_explosion_animation_finished():
	queue_free()
