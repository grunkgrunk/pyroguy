extends Node2D


export(Texture) var blue
export(Texture) var red
export(bool) var emit = false

func _ready():
	set_as_toplevel(true)
	emitting(emit)

func _process(delta):
	if Global.multiplier >= 5:
		set_color("blue")
	else:
		set_color("red")

func emitting(v):
	# $smoke_emitter.emitting  =v 
	$fire_emitter.emitting = v

func set_color(c):
	if c == "red":
		$fire_emitter.texture = red
	if c == "blue":
		$fire_emitter.texture = blue
	

func set_dir(d):
	$fire_emitter.process_material.direction = Vector3(d.x, d.y, 0)
	$smoke_emitter.process_material.direction = Vector3(d.x, d.y, 0)
