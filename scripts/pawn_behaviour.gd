extends Behaviour


func get_valid_moves(
	coords: Vector2i,
	allegiance: Utils.Allegiance,
	first_move: bool = false,
) -> Dictionary:
	var moves: Array[Vector2i] = []
	var takes: Array[Vector2i] = []
	var pos := coords
	
	# Get moves
	pos.y += allegiance
	if Utils.is_within_bounds(pos) and Utils.is_empty(pos):
		moves.append(pos)
	# Check for double step
	if first_move:
		# TODO: solve special kill
		pos.y += allegiance
		if Utils.is_within_bounds(pos) and Utils.is_empty(pos):
			moves.append(pos)
	
	# Get takes
	pos = coords
	pos.y += allegiance
	for i: int in [1, -1]:
		pos.x = coords.x + i
		if Utils.is_within_bounds(pos) and Utils.is_enemy(pos, allegiance):
			takes.append(pos)
	
	return {
		"moves": moves,
		"takes": takes,
	}
