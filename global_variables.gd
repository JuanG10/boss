extends Node

var coin = preload("res://Coin.tscn")

var points = 110

var money = 0
var speed = 3
var atk_speed = .4
var health = 100
var dmg = 10
var magnet_radius = 10
var brn_dmg = 1
var heal_speed = 1.5
var shield_speed = 5

var habilidadres = []

var player


func add_habilidad(name_habilidad):
	if(!existe_habilidad(name_habilidad)):
		habilidadres.append(name_habilidad)


func existe_habilidad(nombre_habilidad):
	var boolean = false 
	for name_habilidad in GlobalVariables.habilidadres:
		boolean = nombre_habilidad == name_habilidad
	return boolean		
	
	
	
	
	
	
	


