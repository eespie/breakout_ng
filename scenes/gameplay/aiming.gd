extends Line2D

@export
var raycast_for_aiming : RayCast2D

@export
var rebound_line :Line2D

func limitAimingPoint(start: Vector2, end : Vector2) -> Vector2:
	var step = 40
	var vec = end - start
	var len = floori(vec.length())
	while end.y < -1380:
		len -= step
		vec = vec.normalized() * len
		end = start + vec
	while end.x < -480 or end.x > 480:
		len -= step
		vec = vec.normalized() * len
		end = start + vec
	
	return end
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rebound_line.hide()
	if not raycast_for_aiming.is_enabled():
		hide()
		return
		
	show()
	var points = PackedVector2Array()
	points.append(Vector2.ZERO)
	var target = raycast_for_aiming.aiming_pos
	var collision_point = to_local(raycast_for_aiming.get_collision_point())
	if target.length() < collision_point.length() or not raycast_for_aiming.is_colliding():
		points.append(limitAimingPoint(Vector2.ZERO, target))
	else:
		# Ray cast is colliding, find the collision point
		points.append(limitAimingPoint(Vector2.ZERO, collision_point))
		var remaining_length = target.length() - collision_point.length()
		# and the rebound
		var normal = raycast_for_aiming.get_collision_normal()
		if normal.y == 0:
			var rebound_points = PackedVector2Array()
			rebound_points.append(collision_point)
			var rebound = target.bounce(normal).normalized() * remaining_length + collision_point
			rebound_points.append(limitAimingPoint(collision_point, rebound))
			rebound_line.set_points(rebound_points)
			rebound_line.show()
	set_points(points)
