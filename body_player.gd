extends Area2D

signal dead
signal hit
signal burns

export var burn_time = 2
var health_before_ignition = 0.2
onready var max_burn_time = burn_time
export var damage = 1
var burns_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$fire.global_position = global_position
	$regen_timer.connect("timeout", self, "on_regen")
	$burn_timer.connect("timeout", self, "on_burntimer")
	
func _process(delta):
	$fire.global_position = global_position
	if health_before_ignition < 0:
		burn_time -= delta
		if not burns_started:
			$fire.emitting(true)
			$fire_sound.play()
			emit_signal("burns")
			burns_started = true
			$burn_timer.start()
		else:
			for a in get_overlapping_areas():
				if a.is_in_group("can_ignite"):
					a.hit(damage, delta)

func hit(dmg, delta):
	$AnimationPlayer.play("hurt")
	emit_signal("hit")
	health_before_ignition -= 1 * dmg * delta
	$regen_timer.start()


func on_regen():
	health_before_ignition = 0.5
	
func on_burntimer():
	burns_started = false
	$fire.emitting(false)
	$fire_sound.stop()
	health_before_ignition = 0.5
	
