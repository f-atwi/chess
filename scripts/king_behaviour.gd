extends Behaviour

#func get_valid_moves(coords: Vector2i, forward_direction: int, first_move: bool = false) -> Dictionary:
	#var moves: Array[Vector2i] = []
	#var pos: Vector2i
	#for i in range(-1, 2):
		#for j in range(-1, 2):
			#if i == 0 and j == 0:
				#continue
			#pos = Vector2i(coords.x + i, coords.y + j)
			#print("pos ", pos)
			#if Utils.is_within_bounds(pos) and Utils.is_empty(coords):
				#print("valid")
				#moves.append(pos)
#
	#return moves
