extends Line2D

@export
var raycast_for_aiming : RayCast2D

@export
var rebound_line :Line2D

func limitAimingPoint(start: Vector2, end : Vector2) -> Vector2:
	var step = 40
	var vec = end - start
	var vec_len = floori(vec.length())
	while end.y < -1380:
		vec_len -= step
		vec = vec.normalized() * vec_len
		end = start + vec
	while end.x < -480 or end.x > 480:
		vec_len -= step
		vec = vec.normalized() * vec_len
		end = start + vec
	
	return end
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rebound_line.hide()
	if not raycast_for_aiming.is_enabled():
		hide()
		return
		
	show()
	var line_points = PackedVector2Array()
	line_points.append(Vector2.ZERO)
	var target = raycast_for_aiming.aiming_pos
	var collision_point = to_local(raycast_for_aiming.get_collision_point())
	if target.length() < collision_point.length() or not raycast_for_aiming.is_colliding():
		line_points.append(limitAimingPoint(Vector2.ZERO, target))
	else:
		# Ray cast is colliding, find the collision point
		line_points.append(limitAimingPoint(Vector2.ZERO, collision_point))
		var remaining_length = target.length() - collision_point.length()
		# and the rebound
		if collision_point.y > -1380:
			var normal = raycast_for_aiming.get_collision_normal()
			if normal.y == 0:
				var rebound_points = PackedVector2Array()
				rebound_points.append(collision_point)
				var rebound = target.bounce(normal).normalized() * remaining_length + collision_point
				rebound_points.append(limitAimingPoint(collision_point, rebound))
				rebound_line.set_points(rebound_points)
				rebound_line.show()
	set_points(line_points)
