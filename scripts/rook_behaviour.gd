extends Behaviour

func get_valid_moves(
	coords: Vector2i,
	allegiance: Utils.Allegiance,
	first_move: bool = false,
) -> Dictionary:
	var moves: Dictionary = {
		"moves": [],
		"takes": [],
	}

	# Get moves in vertical and horizontal directions
	moves = _add_moves_in_direction(coords, moves, allegiance, Vector2i(0, 1))
	moves = _add_moves_in_direction(coords, moves, allegiance, Vector2i(0, -1))
	moves = _add_moves_in_direction(coords, moves, allegiance, Vector2i(1, 0))
	moves = _add_moves_in_direction(coords, moves, allegiance, Vector2i(-1, 0))

	return moves

func _add_moves_in_direction(coords: Vector2i, moves: Dictionary, allegiance: Utils.Allegiance, delta: Vector2i) -> Dictionary:
	while true:
		coords += delta
		if not Utils.is_within_bounds(coords):
			break
		if Utils.is_empty(coords):
			moves["moves"].append(coords)
		elif Utils.is_enemy(coords, allegiance):
			moves["takes"].append(coords)
			break
		else:
			break
	return moves
