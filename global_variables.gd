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

var habilidades_Green = []
var habilidades_Red   = []
var habilidades_Blue  = []

var player


func add_habilidad_Blue(name_habilidad):
	if(!existe_habilidad(name_habilidad,habilidades_Blue)):
		habilidades_Blue.append(name_habilidad)

func add_habilidad_Red(name_habilidad):
	if(!existe_habilidad(name_habilidad,habilidades_Red)):
		habilidades_Red.append(name_habilidad)

func add_habilidad_Green(name_habilidad):
	if(!existe_habilidad(name_habilidad,habilidades_Green)):
		habilidades_Green.append(name_habilidad)
		
		
func existe_habilidad(nombre_habilidad,list_habilidades):
	var boolean = false 
	for name_habilidad in list_habilidades:
		boolean = nombre_habilidad == name_habilidad
	return boolean		
	
	
	
	
	
	
	


