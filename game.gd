extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var game
export(PackedScene) var gameover
export(PackedScene) var start
var current = ""
# Called when the node enters the scene tree for the first time.
func _ready():	
	start("blue_gameover")

func start(start_from):
	current = start_from
	if start_from == "intro":
		add_child(start.instance())
	if start_from == "blue_gameover":
		add_child(blue_dead())
	if start_from == "red_gameover":
		add_child(red_dead())
	if start_from == "timesup":
		add_child(timesup())
	if start_from == "game":
		var z = game.instance()
		add_child(z)
		$game_world/objects/p1.connect("gameover", self, "blue")
		$game_world/objects/p2.connect("gameover", self, "red")
		$game_world/CanvasLayer/game_timer.connect("timeout", self, "time")
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current != "game" and Input.is_action_just_pressed("ui_accept"):
		for a in get_children():
			a.queue_free()
		Global.score = 0
		Global.multiplier = 1
		
		start("game")
		
func wizard_dead(p):
	# $game_world.queue_free()
	for a in get_children():
		a.queue_free()
	var v = gameover.instance()
	v.reason = p
	return v

func red():
	start("red_gameover")
func blue():
	start("blue_gameover")
func time():
	start("timesup")
	

func blue_dead():
	return wizard_dead("Blue wizard has fallen")

func red_dead():
	return wizard_dead("Red wizard has fallen")
	
func timesup():
	print("yosss")
	return wizard_dead("Time's up!")
	

