extends Behaviour


const DELTAS: Array[Vector2i] = [
	Vector2i(0, 1),
	Vector2i(-1, 0),
	Vector2i(0, -1),
	Vector2i(1, 0),
	Vector2i(1, 1),
	Vector2i(1, -1),
	Vector2i(-1, -1),
	Vector2i(-1, 1),
]


func get_valid_moves(
	coords: Vector2i,
	allegiance: Utils.Allegiance,
	_first_move: bool = false,
) -> Dictionary:
	var moves: Dictionary = {
		"moves": [],
		"takes": [],
	}

	for delta in DELTAS:
		add_moves_in_direction(coords, moves, allegiance, delta)

	return moves
