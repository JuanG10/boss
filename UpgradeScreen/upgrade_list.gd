extends ItemList

onready var parent_name = get_parent().name
const ICON_SIZE = Vector2(100,100)

const intPrecio = 30
const precio = "$" + str(intPrecio) # Debería ir incrementando.

# Iconos. Hardcodeado por ahora.
const BASE = {
	bala = preload("res://Iconos/bala_base.png"),
	escudo = preload("res://Iconos/defensa_base.png"),
	limitador = preload("res://Iconos/limitador_base.png"),
	pistola = preload("res://Iconos/pistola_base.png")
}
const GREEN = {
	cuchillo = preload("res://Iconos/cuchillo_azul-violeta.png"),
	pistola = preload("res://Iconos/pistola_azul-violeta.png")
}
func _input(event):
	if event is InputEventMouseButton :
			if get_selected_items().size() > 0:
				print(get_selected_items()[0])

func _physics_process(delta):
	if parent_name == "BasePanel":
		#print(get_item_text(0))
		#print(1)
		pass

func _ready():
	set_fixed_icon_size(ICON_SIZE)
	if parent_name == "BasePanel":
		add_item("Bala: +Cadencia " + precio, BASE.bala) #0
		add_item("Limitador: +Velocidad " + precio, BASE.limitador) #1
		add_item("Escudo: +Vida " + precio, BASE.escudo) #2
		add_item("Pistola: +Daño " + precio, BASE.pistola) #3
	elif parent_name == "RedPanel":
		add_item("Cuchillo: +Daño a corta distancia contra rojo", GREEN.cuchillo)
		add_item("Pistola: +Daño a distancia contra rojo", GREEN.pistola)
	elif parent_name == "GreenPanel":
		add_item("Cuchillo: +Daño a corta distancia contra verde", GREEN.cuchillo)
		add_item("Pistola: +Daño a distancia contra verde", GREEN.pistola)


func _on_list_item_activated(_index):
	# Muchos if hardcodeados, refactor junto con el jugador.
	#GlobalVariables.money >= intPrecio
	if true:
		GlobalVariables.money -= intPrecio
		get_parent().get_node("Coins").on_update()
		#print(get_parent().get_parent().get_parent().name)
		if _get_selected_item()   == 0: 
			GlobalVariables.habilidadres.append("atk_spped")
		elif _get_selected_item() == 1: 
			GlobalVariables.habilidadres.append("Speed")
		elif _get_selected_item() == 2: 
			GlobalVariables.habilidadres.append("shield")
		elif _get_selected_item() == 3: 
			GlobalVariables.habilidadres.append("damage")

		else: pass
	#print("VelocidadAtaque: ", GlobalVariables.atk_speed," Velocidad: ", GlobalVariables.speed, " Vida: ",GlobalVariables.health, " Daño: ", GlobalVariables.dmg)

func _get_selected_item()->int:
	return get_selected_items()[0]
