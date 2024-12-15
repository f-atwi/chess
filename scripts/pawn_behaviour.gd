extends Behaviour


func get_valid_moves(coords: Vector2i, forward_direction: int, first_move: bool = false) -> Dictionary:
	var moves: Dictionary = {
		"moves": [],
		"takes": [],
	}
	var pos := coords
	
	# Get moves
	pos.y += forward_direction
	if Utils.is_within_bounds(pos) and Utils.is_empty(pos):
		moves["moves"].append(pos)
	# Check for double step
	if first_move:
		# TODO: solve special kill
		pos.y += forward_direction
		if Utils.is_within_bounds(pos) and Utils.is_empty(pos):
			moves["moves"].append(pos)
	
	# Get takes
	pos = coords
	pos.y += forward_direction
	for i in [1, -1]:
		pos.x = coords.x + i
		if Utils.is_within_bounds(pos) and Utils.is_enemy(pos, forward_direction):
			moves["takes"].append(pos) 
	
	return moves
