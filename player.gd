extends KinematicBody2D

signal gameover
export(PackedScene) var particle
signal shooting

export(int) var player_num

var last_dir = Vector2(1,0)
var move_speed = 100
var damage = 1
var speed_when_fire = 50
var cur_speed = 0
var t = 0
var lives = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	var p = Vector2()
	if player_num == 1:
		p = Vector2(143, 223)
	if player_num == 2:
		p = Vector2(143 - 16, 223) 
	
	$Sprite.region_rect = Rect2(p, Vector2(16,16))
	$body.connect("burns", self, "on_burns")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	$fire.global_position = global_position
	var vel = Vector2()
	if Input.is_action_pressed("left_" + str(player_num)):
		vel.x = -1
	if Input.is_action_pressed("right_" + str(player_num)):
		vel.x = 1
	if Input.is_action_pressed("up_" + str(player_num)):
		vel.y = -1
	if Input.is_action_pressed("down_" + str(player_num)):
		vel.y = 1
	vel = vel.normalized()
	if vel.length() > 0:
		last_dir = vel
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.stop()
	
	$Sprite.flip_h = last_dir.x < 0
	$fire.emitting(false)
	cur_speed = move_speed
	if Input.is_action_pressed("shoot_" + str(player_num)):
		$fire.position = position + last_dir * 9
		cur_speed = speed_when_fire
		$fire.set_dir(last_dir)
		$fire.emitting(true)
		emit_signal("shooting")
		$aim.position = last_dir * 25
		$Sprite.position.x = sin(t*100)
		
		
		$aim.rotation = last_dir.angle() 
		for r in $aim.get_overlapping_areas():
			if r.is_in_group("can_ignite") and r != $body:
				r.hit(damage, delta)
	
	if Input.is_action_just_pressed("shoot_" + str(player_num)):
		$fire_vol.stop_all()
		$fire_sound.volume_db = 0
		$fire_sound.play()
		$AnimationPlayer.play("shoot")
		
	if Input.is_action_just_released("shoot_" + str(player_num)):
		$fire_vol.interpolate_property($fire_sound, "volume_db", 0, -100, 1)
		$fire_vol.start()
		
	
	move_and_slide(vel * cur_speed)

func on_burns():
	lives -= 1
	print("sdaasd")
	if lives == 0:
	
		emit_signal("gameover")
