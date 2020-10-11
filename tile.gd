extends Node2D

signal dead
var grid_pos = Vector2()

func _ready():
	$rip.frame = randi() % 3
	$rip.hide()
	$rip.position += r() * 2

func set_region(r):
	$Sprite.region_rect = r

func _on_body_dead(s):
	emit_signal("dead", grid_pos)
	$Sprite.hide()
	$body.queue_free()
	$rip.show()

func r():
	var a = rand_range(0, 2*PI)
	return Vector2(cos(a), sin(a))
