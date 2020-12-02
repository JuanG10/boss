extends Node

var player

var heal = true
var shield = false


var timer = Timer.new()

func _ready():
	timer.set_one_shot(true)
	timer.connect("timeout",self,"_on_timer_timeout")
	add_child(timer)

func initialize(p):
	player = p

func handle(_body):
	pass

func power():
	if GlobalVariables.OrangeSpecial:
		player.habilityT.start()
		player.hability_bar.start_progress(player.colores[player.pointer])
		player.invencibility = true
		player.invencibility_shield.show()
		timer.start(GlobalVariables.invincibility_time)

#func _process(_delta):
#	if timer.is_stopped():
#		player.invencibility = false

func _on_timer_timeout():
	player.invencibility = false
	player.invencibility_shield.hide()
