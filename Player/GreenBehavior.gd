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

func handle(_body):
	pass

func power():
	if GlobalVariables.OrangeSpecial:
		player.invencibility = true
		timer.start(GlobalVariables.invincibility_time)

func _process(_delta):
	if timer.is_stopped():
		player.invencibility = false
