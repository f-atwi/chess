extends Behaviour


const DELTAS: Array[Vector2i] = [
	Vector2i(1, 2),
	Vector2i(1, -2),
	Vector2i(-1, -2),
	Vector2i(-1, 2),
	Vector2i(2, 1),
	Vector2i(2, -1),
	Vector2i(-2, -1),
	Vector2i(-2, 1),
]


func get_valid_moves(
	coords: Vector2i,
	allegiance: Utils.Allegiance,
	_first_move: bool = false,
) -> Dictionary:
	var moves: Array[Vector2i] = []
	var takes: Array[Vector2i] = []
	var pos: Vector2i
	for delta in DELTAS:
		pos = coords + delta
		if Utils.is_within_bounds(pos):
			if Utils.is_empty(pos):
				moves.append(pos)
			elif Utils.is_enemy(pos, allegiance):
				takes.append(pos)

	return {
		"moves": moves,
		"takes": takes,
	}
