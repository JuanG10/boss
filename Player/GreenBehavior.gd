extends Node

var player

var heal = true
var shield = false


var timer = Timer.new()

func _ready():
	timer.set_one_shot(true)
	add_child(timer)

func initialize(p):
	player = p

func handle(body):
	pass

func power():
	player.invencibility = true
	timer.start(GlobalVariables.invincibility_time)

func _process(_delta):
	if timer.is_stopped():
		player.invencibility = false
