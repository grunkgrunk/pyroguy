extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	$score.text = str(Global.score)
	$mult.text = "X" + str(Global.multiplier)
	$time_left.text = "Time left: " + str(round($game_timer.time_left))
