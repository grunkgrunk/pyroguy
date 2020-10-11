extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x = 0
var y = 200
export(PackedScene) var emitter
var shake = false
var time = 0
var amp = 10
var ix = 0
var iy = 0
var showtime = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$firestarter.connect("timeout", self, "t")
	$showtimer.connect("timeout", self, "s")
	$press_to_play.connect("timeout", self, "w")
	$blink.connect("timeout", self, "b")
	
	var ix = $Label.position.x
	var iy = $Label.position.y



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if shake:
		$Label.position.x = ix + sin(time * 100) * amp
		$Label.rotation = rand_range(-0.01, 0.01) * amp
		# $Label.position.y += sin(time * 100+ 1231) * amp
		# $Label.rect_rotation += sin(time * 100) * 0.01
		amp -= 10 * delta
		if amp <= 0:
			amp = 0
			$Label.position.x = ix
			$Label.position.y = iy
			
			
		
		

func t():
	var e = emitter.instance()
	e.emit = true
	e.global_position = Vector2(x, y)
	add_child(e)
	x += 30
	if x > 1000:
		$firestarter.queue_free()
func s():
	$Label.show()
	shake = true
	$explosion.play()
	
	
	
func w():
	$Label2.show()
	showtime = true

func b():
	if showtime:
		$Label2.visible = !$Label2.visible
