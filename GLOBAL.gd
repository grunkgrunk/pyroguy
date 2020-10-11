extends Node

signal turned_crazy

var score = 0
var last_score_mult = 0
var multiplier = 1
var till_next_multiplier = 500
var has_turned_crazy = false


func _ready():
	$Timer.connect("timeout", self, "timeout")

func _process(dt):
	var diff = abs(score - last_score_mult)
	if diff > till_next_multiplier * multiplier * 1.1:
		multiplier += 1
		last_score_mult = score
		if multiplier >= 5 and not has_turned_crazy:
			has_turned_crazy = true
			$explosion.play()
			$explosion2.play()
			emit_signal("turned_crazy")

func incr_score(by):
	$Timer.start()
	score += by
		
func timeout():
	if multiplier > 1:
		multiplier -= 1
		if multiplier < 5:
			has_turned_crazy = false
		last_score_mult = score
	
