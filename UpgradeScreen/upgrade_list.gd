extends ItemList

onready var parent_name = get_parent().name
const ICON_SIZE = Vector2(100,100)

const intPrecio = 30
const precio = "$" + str(intPrecio) # Debería ir incrementando.

# Iconos. Hardcodeado por ahora.

const BASE = {
	bala = preload("res://Iconos/bala_base.png"),
	limitador = preload("res://Iconos/limitador_base.png"),
	escudo = preload("res://Iconos/defensa_base.png"),
	pistola = preload("res://Iconos/pistola_base.png")
}
const GREEN = {
	cuchillo = preload("res://Iconos/cuchillo_azul-violeta.png"),
	escudo = preload("res://Iconos/defensa_base.png"),
	pistola = preload("res://Iconos/pistola_azul-violeta.png")
}
const BLUE = {
	corazon = preload("res://Iconos/corazon.png")
}

var MONEDA = preload("res://moneda_particula/Moneda_particula.tscn").instance()

func _input(event):
	if event is InputEventMouseButton :
			if get_selected_items().size() > 0:
				_on_list_item_activated(1)
				
				
func _ready():
	set_fixed_icon_size(ICON_SIZE)
	if parent_name == "BasePanel":
		add_item("Bala: +Cadencia " + precio, BASE.bala) #0
		add_item("Limitador: +Velocidad " + precio, BASE.limitador) #1
		add_item("Pistola: +Daño " + precio, BASE.pistola) #3
		add_item("Escudo: +Vida " + precio, GREEN.escudo) #2
	elif parent_name == "RedPanel":
		add_item("Cuchillo: +Daño a corta distancia contra rojo", GREEN.cuchillo)
		add_item("Pistola: +Daño a distancia contra rojo", GREEN.pistola)
		add_item("Bala: +Cadencia " + precio, BASE.bala) 
	elif parent_name == "GreenPanel":
		#add_item("Cuchillo: +Daño a corta distancia contra verde", GREEN.cuchillo)
		#add_item("Pistola: +Daño a distancia contra verde", GREEN.pistola)
		add_item("Escudo: +Vida " + precio, GREEN.escudo) #2
	elif parent_name == "BluePanel":
		add_item("Corazon: +Vida" + precio,BLUE.corazon)

func animacion_monedas():
	var posicion_mondea = get_local_mouse_position()
	var monedas         = preload("res://moneda_particula/Moneda_particula.tscn").instance()
	monedas.position = posicion_mondea
	add_child(monedas)
	

func _on_list_item_activated(_index):
	# Muchos if hardcodeados, refactor junto con el jugador.
	#GlobalVariables.money >= intPrecio
	if true:
		GlobalVariables.money -= intPrecio
		get_parent().get_node("Coins").on_update()
		#print(get_parent().get_parent().get_parent().name)
		if parent_name == "BasePanel":
			compra_base_panel()
		elif parent_name == "RedPanel":
			comprar_red_panel()	
		elif parent_name == "GreenPanel":
			comprar_green_panel()	
		elif parent_name == "BluePanel":
			comprar_blue_panel()	

		else: pass
	#print("VelocidadAtaque: ", GlobalVariables.atk_speed," Velocidad: ", GlobalVariables.speed, " Vida: ",GlobalVariables.health, " Daño: ", GlobalVariables.dmg)
func compra_base_panel():
	if _get_selected_item()   == 0: 
			GlobalVariables.add_habilidad("atk_speed")
			animacion_monedas()
			music_moneda_play()
	elif _get_selected_item() == 1: 
			GlobalVariables.add_habilidad("Speed")
			animacion_monedas()
			music_moneda_play()
	elif _get_selected_item() == 2: 
			GlobalVariables.add_habilidad("damage")
			animacion_monedas()
			music_moneda_play()
	elif _get_selected_item() == 3:
			animacion_monedas() 
			GlobalVariables.add_habilidad("shield")
			music_moneda_play()



func comprar_red_panel():
	if _get_selected_item()   == 0: 
			GlobalVariables.add_habilidad("Cuchillo")
			music_moneda_play()
	elif _get_selected_item() == 1: 
			GlobalVariables.add_habilidad("damage_1")
			music_moneda_play()
	elif _get_selected_item()   == 2: 
			GlobalVariables.add_habilidad("atk_speed")
			music_moneda_play()

func comprar_green_panel():
	if _get_selected_item() == 0: 
		GlobalVariables.add_habilidad("shield")
		music_moneda_play()

func comprar_blue_panel():
	if _get_selected_item() == 0:
		GlobalVariables.add_habilidad("Corazon")
		music_moneda_play()







func music_moneda_play():
	get_parent().get_node("music_moneda").play() 
	$Timer.set_wait_time(2)
	$Timer.start()
func music_moneda_stop():
	get_parent().get_node("music_moneda").stop()
	
func _get_selected_item()->int:
	return get_selected_items()[0]


func _on_Timer_timeout():
	music_moneda_stop()
