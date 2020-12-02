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
var intPrecioHP       = 20
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
var intPrecioStun     = 40
var precioStun        = "$" + str(intPrecioStun)

var InvTUpgCounter    = 0
var intPrecioInvT     = 270
var precioInvT        = "$" + str(intPrecioInvT)

var laserUpgCounter   = 0
var intPrecioLaser    = 340
var precioLaser       = "$" + str(intPrecioInvT)

var SlowUpgCounter    = 0
var intPrecioSlow     = 30
var precioSlow        = "$" + str(intPrecioInvT)

var SlowRngUpgCounter = 0
var intPrecioSlowRing = 190
var precioSlowRing    = "$" + str(intPrecioInvT)

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
		GlobalVariables.heal_speed = 1.3
		intPrecioHealS   = 200
		HealSUpgCounter += 1
		precioHealS      = "$" + str(intPrecioHealS)
		upgradeList.set_item_text(1, "Heal Speed: " + precioHealS)
	elif HealSUpgCounter == 1:
		GlobalVariables.heal_speed   = 1
		intPrecioHealS   = 320
		HealSUpgCounter += 1
		precioHealS      = "$" + str(intPrecioHealS)
		upgradeList.set_item_text(1, "Heal Speed: " + precioHealS)
	elif HealSUpgCounter == 2:
		GlobalVariables.heal_speed   = .5
		intPrecioHealS   = 700
		HealSUpgCounter += 1
		precioHealS      = "$" + str(intPrecioHealS)
		upgradeList.set_item_text(1, "Heal Speed: " + precioHealS)
	elif HealSUpgCounter == 3:
		GlobalVariables.heal_speed   = .3
		intPrecioHealS   = 1000
		HealSUpgCounter += 1
		precioHealS      = "$" + str(intPrecioHealS)
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

func laserUpgrade(upgradeList):
	if laserUpgCounter == 0:
		GlobalVariables.RedSpecial = true
		intPrecioLaser   = 200
		laserUpgCounter += 1
		precioLaser      = "$" + str(intPrecioLaser)
		upgradeList.set_item_text(2, "Laser Damage: " + precioLaser)
	elif laserUpgCounter == 1:
		GlobalVariables.LaserDMG = 50
		intPrecioLaser   = 410
		laserUpgCounter += 1
		precioLaser      = "$" + str(intPrecioLaser)
		upgradeList.set_item_text(2, "Laser Damage: " + precioLaser)
	elif laserUpgCounter == 2:
		GlobalVariables.LaserDMG = 90
		intPrecioLaser   = 560
		laserUpgCounter += 1
		precioLaser      = "$" + str(intPrecioLaser)
		upgradeList.set_item_text(2, "Laser Damage: " + precioLaser)
	elif laserUpgCounter == 3:
		GlobalVariables.LaserDMG = 140
		intPrecioLaser   = 800
		laserUpgCounter += 1
		precioLaser      = "$" + str(intPrecioLaser)
		upgradeList.set_item_text(2, "Laser Damage: " + precioLaser)
	elif laserUpgCounter == 4:
		GlobalVariables.LaserDMG = 200
		precioLaser      = "SOLD OUT"
		laserUpgCounter += 1
		upgradeList.set_item_text(2, "Laser Damage: " + precioLaser)

func InvuleravilityUpgrade(upgradeList):
	if InvTUpgCounter == 0:
		GlobalVariables.OrangeSpecial = true
		intPrecioInvT   = 160
		InvTUpgCounter += 1
		precioInvT      = "$" + str(intPrecioInvT)
		upgradeList.set_item_text(3, "Invulnerability Time: " + precioInvT)
	elif InvTUpgCounter == 1:
		GlobalVariables.invincibility_time = 3
		intPrecioInvT   = 300
		InvTUpgCounter += 1
		precioInvT      = "$" + str(intPrecioInvT)
		upgradeList.set_item_text(3, "Invulnerability Time: " + precioInvT)
	elif InvTUpgCounter == 2:
		GlobalVariables.invincibility_time = 3.5
		intPrecioInvT   = 470
		InvTUpgCounter += 1
		precioInvT      = "$" + str(intPrecioInvT)
		upgradeList.set_item_text(3, "Invulnerability Time: " + precioInvT)
	elif InvTUpgCounter == 3:
		GlobalVariables.invincibility_time = 4
		intPrecioInvT   = 650
		InvTUpgCounter += 1
		precioInvT      = "$" + str(intPrecioInvT)
		upgradeList.set_item_text(3, "Invulnerability Time: " + precioInvT)
	elif InvTUpgCounter == 4:
		GlobalVariables.invincibility_time = 5
		precioInvT      = "SOLD OUT"
		InvTUpgCounter += 1
		upgradeList.set_item_text(3, "Invulnerability Time: " + precioInvT)

func slowRingUpgrade(upgradeList):
	if SlowRngUpgCounter == 0:
		GlobalVariables.BlueSpecial = true
		intPrecioSlowRing   = 100
		SlowRngUpgCounter  += 1
		precioSlowRing      = "$" + str(intPrecioSlowRing)
		upgradeList.set_item_text(3, "Slow ring: " + precioSlowRing)
	elif SlowRngUpgCounter == 1:
		GlobalVariables.slow_ring_effect = .6
		intPrecioSlowRing   = 230
		SlowRngUpgCounter  += 1
		precioSlowRing      = "$" + str(intPrecioSlowRing)
		upgradeList.set_item_text(3, "Slow ring: " + precioSlowRing)
	elif SlowRngUpgCounter == 2:
		GlobalVariables.slow_ring_effect = .5
		intPrecioSlowRing   = 370
		SlowRngUpgCounter  += 1
		precioSlowRing      = "$" + str(intPrecioSlowRing)
		upgradeList.set_item_text(3, "Slow ring: " + precioSlowRing)
	elif SlowRngUpgCounter == 3:
		GlobalVariables.slow_ring_effect = .4
		intPrecioSlowRing   = 590
		SlowRngUpgCounter  += 1
		precioSlowRing      = "$" + str(intPrecioSlowRing)
		upgradeList.set_item_text(3, "Slow ring: " + precioSlowRing)
	elif SlowRngUpgCounter == 4:
		GlobalVariables.slow_ring_effect = .2
		precioSlowRing      = "SOLD OUT"
		SlowRngUpgCounter  += 1
		upgradeList.set_item_text(3, "Slow ring: " + precioSlowRing)

func slowUpgrade(upgradeList):
	if SlowUpgCounter == 0:
		GlobalVariables.Pslow = .7
		intPrecioSlow   = 50
		SlowUpgCounter += 1
		precioSlow      = "$" + str(intPrecioSlow)
		upgradeList.set_item_text(2, "Slow: " + precioSlow)
	elif SlowUpgCounter == 1:
		GlobalVariables.Pslow   = .65
		intPrecioSlow   = 80
		SlowUpgCounter += 1
		precioSlow      = "$" + str(intPrecioSlow)
		upgradeList.set_item_text(2, "Slow: " + precioSlow)
	elif SlowUpgCounter == 2:
		GlobalVariables.Pslow   = .6
		intPrecioSlow   = 120
		SlowUpgCounter += 1
		precioSlow      = "$" + str(intPrecioSlow)
		upgradeList.set_item_text(2, "Slow: " + precioSlow)
	elif SlowUpgCounter == 3:
		GlobalVariables.Pslow   = .55
		intPrecioSlow   = 150
		SlowUpgCounter += 1
		precioSlow      = "$" + str(intPrecioSlow)
		upgradeList.set_item_text(2, "Slow: " + precioSlow)
	elif SlowUpgCounter == 4:
		GlobalVariables.Pslow   = .5
		precioSlow      = "SOLD OUT"
		SlowUpgCounter += 1
		upgradeList.set_item_text(2, "Slow: " + precioSlow)

func stunUpgrade(upgradeList):
	if StunUpgCounter == 0:
		GlobalVariables.Pstun = .2
		intPrecioStun   = 60
		StunUpgCounter += 1
		precioStun      = "$" + str(intPrecioStun)
		upgradeList.set_item_text(1, "Stun Duration: " + precioStun)
	elif StunUpgCounter == 1:
		GlobalVariables.Pstun   = .25
		intPrecioStun   = 90
		StunUpgCounter += 1
		precioStun      = "$" + str(intPrecioStun)
		upgradeList.set_item_text(1, "Stun Duration: " + precioStun)
	elif StunUpgCounter == 2:
		GlobalVariables.Pstun   = .3
		intPrecioStun   = 130
		StunUpgCounter += 1
		precioStun      = "$" + str(intPrecioStun)
		upgradeList.set_item_text(1, "Stun Duration: " + precioStun)
	elif StunUpgCounter == 3:
		GlobalVariables.Pstun   = .35
		intPrecioStun   = 160
		StunUpgCounter += 1
		precioStun      = "$" + str(intPrecioStun)
		upgradeList.set_item_text(1, "Stun Duration: " + precioStun)
	elif StunUpgCounter == 4:
		GlobalVariables.Pstun   = .4
		precioStun      = "SOLD OUT"
		StunUpgCounter += 1
		upgradeList.set_item_text(1, "Stun Duration: " + precioStun)
