extends Node

var coin = preload("res://Coin.tscn")
const EXPLOSION = preload("res://Enemies/Explosion/Explosion.tscn")

var retry = false

var invincibility_time = 2.5

var money            = 0
var Pspeed           = 3    #mejora aumentando el valor
var Patk_speed       = .4   #mejora disminuyendo el valor
var Phealth          = 100  #mejora aumentando el valor
var Pdmg             = 10   #mejora aumentando el valor
var Pslow            = .8   #mejora disminuyendo el valor
var Pstun            = .1   #mejora aumentando el valor
var magnet_radius    = 10   #mejora aumentando el valor
var brn_dmg          = 1    #mejora aumentando el valor
var heal_speed       = 1.5  #mejora disminuyendo el valor
var shield_speed     = 5    #mejora disminuyendo el valor
var slow_ring_effect = .7   #mejora disminuyendo el valor
var BFdmg            = 3   #mejora aumentando el valor

var Mhealth = 25
var Mdmg    = 15

var Bhealth = 45
var Bdmg    = 20

var Ahealth = 70
var Admg    = 10

var player

func create_timer(time:int, one_shot:bool, who, timer_name:String, timer_stop_function_name:String)->Timer:
	# No la pude probar pero podría servir en un futuro.
	if who.get_node_or_null(timer_name) == null:
		var new_timer = Timer.new()
		new_timer.set_one_shot(one_shot)
		new_timer.set_wait_time(time)
		new_timer.connect("timeout", who, timer_stop_function_name)
		new_timer.set_name(timer_name)
		return new_timer
	else: return null # Sino jode el tipado.
