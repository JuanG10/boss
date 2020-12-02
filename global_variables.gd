extends Node

var coin = preload("res://Coin.tscn")
const EXPLOSION = preload("res://Explosion/Explosion.tscn")
const TEXT = preload("res://Fonts/FloatingText.tscn")

var habilidades = []

var invincibility_time = 2.5

var last_points      = 0
var points           = 0
var money            = 1000
var Pspeed           = 3.5  #mejora aumentando el valor   Naranja
var Patk_speed       = .4   #mejora disminuyendo el valor 
var Phealth          = 100  #mejora aumentando el valor   Azul
var Pdmg             = 10   #mejora aumentando el valor   Rojo
var Pslow            = .8   #mejora disminuyendo el valor
var Pstun            = .1   #mejora aumentando el valor
var magnet_radius    = 10   #mejora aumentando el valor
var brn_dmg          = 1    #mejora aumentando el valor   Rojo
var heal_speed       = 1.5  #mejora disminuyendo el valor Azul
var shield_speed     = 5    #mejora disminuyendo el valor Azul
var slow_ring_effect = .7   #mejora disminuyendo el valor
var LaserDMG         = 20   #mejora aumentando el valor

var RedSpecial    = false
var BlueSpecial   = false
var OrangeSpecial = false

var Mhealth = 25
var Mdmg    = 15

var Bhealth = 45
var Bdmg    = 20

var Ahealth = 70
var Admg    = 10

var player

#func create_timer(time:int, one_shot:bool, who, timer_name:String, timer_stop_function_name:String)->Timer:
#	# No la pude probar pero podría servir en un futuro.
#	if who.get_node_or_null(timer_name) == null:
#		var new_timer = Timer.new()
#		new_timer.set_one_shot(one_shot)
#		new_timer.set_wait_time(time)
#		new_timer.connect("timeout", who, timer_stop_function_name)
#		new_timer.set_name(timer_name)
#		return new_timer
#	else: return null # Sino jode el tipado.
