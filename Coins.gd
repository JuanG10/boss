extends Label

func on_update():
	set_text("Coins: " + str(GlobalVariables.money))
