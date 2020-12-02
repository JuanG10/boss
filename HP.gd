extends Label

func on_update(n):
	set_text("HP:" + str(round(n)))

func change_outline(color:Color):
	 get("custom_fonts/font").outline_color = color
