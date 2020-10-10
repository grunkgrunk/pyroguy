extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self, "modulate", Color(1,0,0,1), Color(1,1,1,0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.1)
	$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func text(t):
	$text.text = t

func _on_Tween_tween_all_completed():
	queue_free()
