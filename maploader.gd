extends Node2D

signal spawn

export(PackedScene) var field


# Called when the node enters the scene tree for the first time.
func _ready():
	load_layer($CanIgnite)
	load_layer($CanIgniteALso)
	
	$CanIgniteALso.queue_free()
	$CanIgnite.queue_free()

func load_layer(layer):
	for s in layer.get_used_cells():
		var l = layer.map_to_world(s)
		var f = field.instance()
		f.global_position = l
		var id = layer.get_cell(s.x, s.y)
		var r = layer.tile_set.tile_get_region(id)
		f.set_region(r)
		emit_signal("spawn", f)
	
		

	
