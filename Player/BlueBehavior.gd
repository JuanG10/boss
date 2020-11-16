extends Node

var player

var heal   = false
var shield = true

func initialize(p):
	player = p

func handle(body):
	body.slow(.8, 2)

func power():
	pass
