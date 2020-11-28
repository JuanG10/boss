extends Node

var DMGUpgCounter     = 0
var intPrecioDMG      = 30
var precioDMG         = "$" + str(intPrecioDMG)
var BRNUpgCounter     = 0
var intPrecioBRN      = 30
var precioBRN         = "$" + str(intPrecioBRN)
var SpeedUpgCounter   = 0
var intPrecioSpeed    = 50
var precioSpeed       = "$" + str(intPrecioSpeed)
var HPUpgCounter      = 0
var intPrecioHP       = 15
var precioHP          = "$" + str(intPrecioHP)
var AtkSUpgCounter    = 0
var intPrecioAtkS     = 80
var precioAtkS        = "$" + str(intPrecioAtkS)
var HealSUpgCounter   = 0
var intPrecioHealS    = 150
var precioHealS        = "$" + str(intPrecioHealS)
var ShieldSUpgCounter = 0
var intPrecioShieldS  = 70
var precioShieldS     = "$" + str(intPrecioShieldS)
var StunUpgCounter    = 0
var intPrecioStun     = 10
var preciStun         = "$" + str(intPrecioStun)
var InvTUpgCounter    = 0
var intPrecioInvT     = 90
var precioInvT        = "$" + str(intPrecioInvT)

func dmgUpgrade(upgradeList):
	if DMGUpgCounter == 0:
		GlobalVariables.Pdmg       = 13
		intPrecioDMG   = 90
		DMGUpgCounter += 1
		precioDMG      = "$" + str(intPrecioDMG)
		upgradeList.set_item_text(0, "Damage: " + precioDMG)
	elif DMGUpgCounter == 1:
		GlobalVariables.Pdmg       = 17
		intPrecioDMG   = 150
		DMGUpgCounter += 1
		precioDMG      = "$" + str(intPrecioDMG)
		upgradeList.set_item_text(0, "Damage: " + precioDMG)
	elif DMGUpgCounter == 2:
		GlobalVariables.Pdmg       = 25
		intPrecioDMG   = 300
		DMGUpgCounter += 1
		precioDMG      = "$" + str(intPrecioDMG)
		upgradeList.set_item_text(0, "Damage: " + precioDMG)
	elif DMGUpgCounter == 3:
		GlobalVariables.Pdmg       = 30
		intPrecioDMG   = 700
		DMGUpgCounter += 1
		precioDMG      = "$" + str(intPrecioDMG)
		upgradeList.set_item_text(0, "Damage: " + precioDMG)
	elif DMGUpgCounter == 4:
		GlobalVariables.Pdmg       = 40
		precioDMG      = "SOLD OUT"
		DMGUpgCounter += 1
		upgradeList.set_item_text(0, "Damage: " + precioDMG)

func speedUpgrade(upgradeList):
	if SpeedUpgCounter == 0:
		GlobalVariables.Pspeed       = 4
		intPrecioSpeed   = 80
		SpeedUpgCounter += 1
		precioSpeed      = "$" + str(intPrecioSpeed)
		upgradeList.set_item_text(0, "Speed: " + precioSpeed)
	elif SpeedUpgCounter == 1:
		GlobalVariables.Pspeed       = 4.5
		intPrecioSpeed   = 140
		SpeedUpgCounter += 1
		precioSpeed      = "$" + str(intPrecioSpeed)
		upgradeList.set_item_text(0, "Speed: " + precioSpeed)
	elif SpeedUpgCounter == 2:
		GlobalVariables.Pspeed       = 5
		intPrecioSpeed   = 210
		SpeedUpgCounter += 1
		precioSpeed      = "$" + str(intPrecioSpeed)
		upgradeList.set_item_text(0, "Speed: " + precioSpeed)
	elif SpeedUpgCounter == 3:
		GlobalVariables.Pspeed       = 5.5
		intPrecioSpeed   = 330
		SpeedUpgCounter += 1
		precioSpeed      = "$" + str(intPrecioSpeed)
		upgradeList.set_item_text(0, "Speed: " + precioSpeed)
	elif SpeedUpgCounter == 4:
		GlobalVariables.Pspeed       = 6
		precioSpeed      = "SOLD OUT"
		SpeedUpgCounter += 1
		upgradeList.set_item_text(0, "Speed: " + precioSpeed)

func healUpgrade(upgradeList):
	if HealSUpgCounter == 0:
		GlobalVariables.heal_speed   = 1.3
		intPrecioHealS   = 200
		HealSUpgCounter += 1
		precioHealS      = "$" + str(intPrecioSpeed)
		upgradeList.set_item_text(1, "Heal Speed: " + precioHealS)
	elif HealSUpgCounter == 1:
		GlobalVariables.heal_speed   = 1
		intPrecioHealS   = 320
		HealSUpgCounter += 1
		precioHealS      = "$" + str(intPrecioSpeed)
		upgradeList.set_item_text(1, "Heal Speed: " + precioHealS)
	elif HealSUpgCounter == 2:
		GlobalVariables.heal_speed   = .5
		intPrecioHealS   = 700
		HealSUpgCounter += 1
		precioHealS      = "$" + str(intPrecioSpeed)
		upgradeList.set_item_text(1, "Heal Speed: " + precioHealS)
	elif HealSUpgCounter == 3:
		GlobalVariables.heal_speed   = .3
		intPrecioHealS   = 1000
		HealSUpgCounter += 1
		precioHealS      = "$" + str(intPrecioSpeed)
		upgradeList.set_item_text(1, "Heal Speed: " + precioHealS)
	elif HealSUpgCounter == 4:
		GlobalVariables.heal_speed   = .2
		precioHealS      = "SOLD OUT"
		HealSUpgCounter += 1
		upgradeList.set_item_text(1, "Heal Speed: " + precioHealS)

func HPUpgrade(upgradeList):
	if HPUpgCounter == 0:
		GlobalVariables.Phealth   = 130
		intPrecioHP   = 50
		HPUpgCounter += 1
		precioHP      = "$" + str(intPrecioHP)
		upgradeList.set_item_text(2, "Health: " + precioHP)
	elif HPUpgCounter == 1:
		GlobalVariables.Phealth   = 180
		intPrecioHP   = 90
		HPUpgCounter += 1
		precioHP      = "$" + str(intPrecioHP)
		upgradeList.set_item_text(2, "Health: " + precioHP)
	elif HPUpgCounter == 2:
		GlobalVariables.Phealth   = 240
		intPrecioHP   = 120
		HPUpgCounter += 1
		precioHP      = "$" + str(intPrecioHP)
		upgradeList.set_item_text(2, "Health: " + precioHP)
	elif HPUpgCounter == 3:
		GlobalVariables.Phealth   = 320
		intPrecioHP   = 210
		HPUpgCounter += 1
		precioHP      = "$" + str(intPrecioHP)
		upgradeList.set_item_text(2, "Health: " + precioHP)
	elif HPUpgCounter == 4:
		GlobalVariables.Phealth   = 400
		precioHP      = "SOLD OUT"
		HPUpgCounter += 1
		upgradeList.set_item_text(2, "Health: " + precioHP)

func atkSpeedUpgrade(upgradeList):
	if AtkSUpgCounter == 0:
		GlobalVariables.Patk_speed  = .35
		intPrecioAtkS   = 150
		AtkSUpgCounter += 1
		precioAtkS       = "$" + str(intPrecioAtkS)
		upgradeList.set_item_text(0, "Patk Speed: " + precioAtkS)
	elif AtkSUpgCounter == 1:
		GlobalVariables.Patk_speed  = .3
		intPrecioAtkS   = 230
		AtkSUpgCounter += 1
		precioAtkS       = "$" + str(intPrecioAtkS)
		upgradeList.set_item_text(0, "Patk Speed: " + precioAtkS)
	elif AtkSUpgCounter == 2:
		GlobalVariables.Patk_speed  = .2
		intPrecioAtkS   = 420
		AtkSUpgCounter += 1
		precioAtkS       = "$" + str(intPrecioAtkS)
		upgradeList.set_item_text(0, "Patk Speed: " + precioAtkS)
	elif AtkSUpgCounter == 3:
		GlobalVariables.Patk_speed  = .15
		intPrecioAtkS   = 670
		AtkSUpgCounter += 1
		precioAtkS       = "$" + str(intPrecioAtkS)
		upgradeList.set_item_text(0, "Patk Speed: " + precioAtkS)
	elif AtkSUpgCounter == 4:
		GlobalVariables.Patk_speed  = .1
		precioAtkS      = "SOLD OUT"
		AtkSUpgCounter += 1
		upgradeList.set_item_text(0, "Patk Speed: " + precioAtkS)

func shieldUpgrade(upgradeList):
	if ShieldSUpgCounter == 0:
		GlobalVariables.shield_speed   = 4.5
		intPrecioShieldS   = 100
		ShieldSUpgCounter += 1
		precioShieldS      = "$" + str(intPrecioShieldS)
		upgradeList.set_item_text(1, "Shield Speed: " + precioShieldS)
	elif ShieldSUpgCounter == 1:
		GlobalVariables.shield_speed   = 4
		intPrecioShieldS   = 150
		ShieldSUpgCounter += 1
		precioShieldS      = "$" + str(intPrecioShieldS)
		upgradeList.set_item_text(1, "Shield Speed: " + precioShieldS)
	elif ShieldSUpgCounter == 2:
		GlobalVariables.shield_speed   = 3.5
		intPrecioShieldS   = 230
		ShieldSUpgCounter += 1
		precioShieldS      = "$" + str(intPrecioShieldS)
		upgradeList.set_item_text(1, "Shield Speed: " + precioShieldS)
	elif ShieldSUpgCounter == 3:
		GlobalVariables.shield_speed   = 3
		intPrecioShieldS   = 350
		ShieldSUpgCounter += 1
		precioShieldS      = "$" + str(intPrecioShieldS)
		upgradeList.set_item_text(1, "Shield Speed: " + precioShieldS)
	elif ShieldSUpgCounter == 4:
		GlobalVariables.shield_speed   = 2.5
		precioShieldS      = "SOLD OUT"
		ShieldSUpgCounter += 1
		upgradeList.set_item_text(1, "Shield Speed: " + precioShieldS)
