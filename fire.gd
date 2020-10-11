extends Node2D

export(PackedScene) var expl
var emitting = false
var state = "normal"

func _ready():
	$emit_speed.connect("timeout", self, "on_timeout")

func _process(delta):
	if emitting:
		var e = expl.instance()
		e.position = global_position
		e.vel = Vector2(0, -1) * rand_range(100, 150)
		if state == "normal":
			$emit_speed.wait_time = 0.01
			e.animation = "normal"
		if state == "blue":
			$emit_speed.wait_time = 0.1
			e.animation = "blue"
		if state == "smoke":
			$emit_speed.wait_time = 0.6
			e.animation = "smoke"
		add_child(e)
		
	
