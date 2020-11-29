extends Node2D

var bullets = []

func _physics_process(delta):
	if not bullets.empty():
		for b in bullets:
			b[0] += Vector2(4, 0).rotated(b[2])
		update()
	for b in bullets:
		if b[3].name == "Player":
			for dicc in get_world_2d().get_direct_space_state().intersect_point(b[0], 1, bullets, 0b100000000, false, true):
				dicc.get("collider").takeDamage(b[3].dmg)
				bullets.erase(b)
		else:
			for dicc in get_world_2d().get_direct_space_state().intersect_point(b[0], 1, bullets, 0b10000000000, false, true):
				dicc.get("collider").takeDamage(b[3].dmg)
				bullets.erase(b)

func reParent(enemy):
	for b in bullets:
		if b[3].get_instance_id() == enemy.get_instance_id():
			var new_parent = Area2D.new()
			new_parent.name = "DEAD"
			b[3] = new_parent

func clear():
	bullets.clear()

func _draw():
	for b in bullets:
		if b[3].name == "Player":
			draw_bullet(b[0], 1, b[1])
		else:
			draw_bullet(b[0], 2.5, b[1])

func draw_bullet(pos, rad, col):
		draw_circle(pos, rad, col)

func add_bullet(b):
	bullets.append(b)
	yield(get_tree().create_timer(3), "timeout")
	bullets.erase(b)

func collision_detected(area):
	if area.is_in_group("Enemy"):
		print("gotcha")
	if area.is_in_group("Player"):
		print("ouch")
