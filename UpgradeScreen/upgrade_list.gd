extends ItemList

onready var parent_name = get_parent().name
const ICON_SIZE = Vector2(100,100)

# Iconos. Hardcodeado por ahora.
const BASE = {
	bala = preload("res://Iconos/bala_base.png"),
	escudo = preload("res://Iconos/defensa_base.png"),
	espada = preload("res://Iconos/espada_base.png"),
	pistola = preload("res://Iconos/pistola_base.png")
}
const GREEN = {
	cuchillo = preload("res://Iconos/cuchillo_azul-violeta.png"),
	pistola = preload("res://Iconos/pistola_azul-violeta.png")
}

func _ready():
	set_fixed_icon_size(ICON_SIZE)
	if parent_name == "BasePanel":
		add_item("Bala: +Cadencia", BASE.bala)
		add_item("Escudo: +Vida", BASE.escudo)
		add_item("Espada: +Daño corta distancia", BASE.espada)
		add_item("Pistola: +Daño a distancia", BASE.pistola)
	elif parent_name == "RedPanel":
		add_item("Cuchillo: +Daño a corta distancia contra rojo", GREEN.cuchillo)
		add_item("Pistola: +Daño a distancia contra rojo", GREEN.pistola)
	elif parent_name == "GreenPanel":
		add_item("Cuchillo: +Daño a corta distancia contra verde", GREEN.cuchillo)
		add_item("Pistola: +Daño a distancia contra verde", GREEN.pistola)
