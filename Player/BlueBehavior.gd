extends Node

var player
onready var slow_ring_template = preload("res://Player/Slow_ring.tscn")

var heal   = false
var shield = true

func initialize(p):
	player = p

func handle(area):
	area.slow(.8, 2)

func power():
	var slow_ring = slow_ring_template.instance()
	slow_ring.position = player.position
	player.get_parent().call_deferred("add_child", slow_ring)
