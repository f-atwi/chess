extends Behaviour


func get_valid_moves(board_position: Vector2i, forward_direction: int, first_move: bool = false) -> Array[Vector2i]:
	var moves: Array[Vector2i] = []
	var pos := board_position
	pos.y += 1*forward_direction
	moves.append(pos)

	# Check for double step
	if first_move:
		# TODO: solve special kill
		pos.y += 1*forward_direction
		moves.append(pos)

	return moves
