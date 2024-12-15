extends Behaviour


func get_valid_moves(coords: Vector2i, forward_direction: int, first_move: bool = false) -> Array[Vector2i]:
	var moves: Array[Vector2i] = []
	coords.y += forward_direction
	if Utils.is_within_bounds(coords):
		moves.append(coords)
	

	# Check for double step
	if first_move:
		# TODO: solve special kill
		coords.y += forward_direction
		if Utils.is_within_bounds(coords):
			moves.append(coords)

	return moves
