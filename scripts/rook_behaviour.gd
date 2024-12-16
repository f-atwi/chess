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
	add_moves_in_direction(coords, moves, allegiance, Vector2i(0, 1))
	add_moves_in_direction(coords, moves, allegiance, Vector2i(0, -1))
	add_moves_in_direction(coords, moves, allegiance, Vector2i(1, 0))
	add_moves_in_direction(coords, moves, allegiance, Vector2i(-1, 0))

	return moves
