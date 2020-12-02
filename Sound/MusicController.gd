extends Node

var actual_bgm:AudioStreamPlayer

onready var blue_bgm = $azul_bucle
onready var orange_bgm = $naranja_bucle
onready var red_bgm = $rojo_bucle

func _ready():
	for child in get_children(): # Para bajarles el volumen.
		child.set_volume_db(child.get_volume_db() - 10)

func change_bgm(next:int)->void:
	if actual_bgm: actual_bgm.stop()
	match next:
		0 : actual_bgm = blue_bgm
		1 : actual_bgm = orange_bgm
		2 : actual_bgm = red_bgm
	actual_bgm.play()

func stop():
	actual_bgm.stop()
