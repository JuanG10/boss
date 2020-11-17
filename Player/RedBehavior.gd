extends Node

var player

onready var BFLaser_template = preload("res://Player/BFLaser.tscn")

var heal = false
var shield = false

func initialize(p):
	player = p

func handle(body):
	body.stun(.1)

func power():
	var BFLaser = BFLaser_template.instance()
	BFLaser.modulate = Color(.702, .0823, .0706)
	BFLaser.position = player.get_node("Muzzle").position
	player.call_deferred("add_child", BFLaser)
