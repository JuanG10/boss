extends Node


func dmgUpgrade(upgradeList):
	if upgradeList.DMGUpgCounter == 0:
		GlobalVariables.Pdmg += 5
