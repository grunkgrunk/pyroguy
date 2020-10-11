extends Node2D

signal dead
var grid_pos = Vector2()

func set_region(r):
	$Sprite.region_rect = r


func _on_body_dead(s):
	emit_signal("dead", grid_pos)
	$Sprite.hide()
	$body.queue_free()
	$rip.show()
