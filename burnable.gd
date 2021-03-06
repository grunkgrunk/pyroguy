extends Area2D

signal burns
signal dead
signal hit

export(PackedScene) var text_display

export var worth = 100
export var health_before_ignition = 2
export var burn_time = 10
onready var max_burn_time = burn_time
export var damage = 1
var is_dead = false
var burns_started = false
onready var extra_damage = rand_range(0, 2)

# Called when the node enters the scene tree for the first time.
func _ready():
	$fire.global_position = global_position
	
func _process(delta):
	if is_dead:
		return
	$fire.global_position = global_position
	if health_before_ignition < 0:
		burn_time -= delta
		if not burns_started:
			$fire.emitting(true)
			$fire_sound.play()
			emit_signal("burns")
			var t = text_display.instance()
			t.text("+" +str(worth * Global.multiplier))
			burns_started = true
			Global.incr_score(worth * Global.multiplier)
			add_child(t)
		if burn_time < 0:
			$fire.emitting(false)
			is_dead = true
			emit_signal("dead", self)
			$fire_vol.interpolate_property($fire_sound, "volume_db", 0, -100, 1)
			$fire_vol.start()
			
		else:
			for a in get_overlapping_areas():
				if a.is_in_group("can_ignite"):
					a.hit(damage + extra_damage, delta)

func hit(dmg, delta):
	emit_signal("hit")
	health_before_ignition -= 1 * dmg * delta

