extends Node2D

export(PackedScene) var expl
var emitting = false

func _process(delta):
	if emitting:
		var e = expl.instance()
		e.standard()
		e.position = global_position
		e.vel = Vector2(0, -1) * rand_range(100, 150)
		add_child(e)
		
	
