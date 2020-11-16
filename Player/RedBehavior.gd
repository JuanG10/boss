extends Node

var player

var heal = false
var shield = false

func initialize(p):
	player = p

func handle(body):
	body.stun(.1)

func power():
	pass
