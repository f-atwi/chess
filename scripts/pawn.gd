extends Piece



func _get_valid_moves() -> Array[Vector2i]:
	var moves: Array[Vector2i] = []
	var pos := board_position
	pos.y += 1*_allegiance
	moves.append(pos)

	# Check for double step
	if _first_move:
		# TODO: solve special kill
		pos.y += 1*_allegiance
		moves.append(pos)

	return moves
