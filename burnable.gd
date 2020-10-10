extends Node2D

signal burns
signal dead
signal hit

export var health_before_ignition = 2
export var burn_time = 10
export var damage = 1
var is_dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Rep
	
func _process(delta):
	if is_dead:
		return
	if health_before_ignition < 0:
		$fire.emitting = true
		burn_time -= delta
		emit_signal("burns")
		if burn_time < 0:
			$fire.emitting = false
			is_dead = true
			emit_signal("dead")
		else:
			for a in $area.get_overlapping_areas():
				if a.is_in_group("can_ignite"):
					a.hit(damage, delta)

func hit(dmg, delta):
	emit_signal("hit")
	health_before_ignition -= 1 * dmg * delta

