extends Behaviour


func get_valid_moves(
	coords: Vector2i,
	allegiance: Utils.Allegiance,
	first_move: bool = false,
) -> Dictionary:
	var moves: Array[Vector2i] = []
	var takes: Array[Vector2i] = []
	var pos: Vector2i
	for i in range(-1, 2):
		for j in range(-1, 2):
			if i == 0 and j == 0:
				continue
			pos = Vector2i(coords.x + i, coords.y + j)
			if Utils.is_within_bounds(pos):
				if Utils.is_empty(pos):
					moves.append(pos)
				elif Utils.is_enemy(pos, allegiance):
					takes.append(pos)

	return {
		"moves": moves,
		"takes": takes,
	}
