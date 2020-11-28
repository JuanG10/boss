extends Node2D

var bullets = []

func _process(_delta):
	if not bullets.empty():
		for b in bullets:
			b[0] += Vector2(5, 0).rotated(b[2])
		update()

func _physics_process(delta):
	for b in bullets:
		if b[3].name == "Player":
			for dicc in get_world_2d().get_direct_space_state().intersect_point(b[0], 1, bullets, 0b100000000, false, true):
				dicc.get("collider").takeDamage(b[3].dmg)
				bullets.erase(b)
		else:
			for dicc in get_world_2d().get_direct_space_state().intersect_point(b[0], 1, bullets, 0b10000000000, false, true):
				dicc.get("collider").takeDamage(b[3].dmg)
				bullets.erase(b)

func clear():
	bullets.clear()

func _draw():
	for b in bullets:
		if b[3].name == "Player":
			draw_bullet(b[0], 1, b[1])
		else:
			draw_bullet(b[0], 2, b[1])

func draw_bullet(pos, rad, col):
		draw_circle(pos, rad, col)

func add_bullet(b):
	bullets.append(b)

func collision_detected(area):
	if area.is_in_group("Enemy"):
		print("gotcha")
	if area.is_in_group("Player"):
		print("ouch")
