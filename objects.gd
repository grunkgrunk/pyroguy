extends YSort


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_puroguyignitable_spawn(o):
	print(o)
	$static.add_child(o)
	