class_name Behaviour
extends Node


func get_valid_moves(
	_coords: Vector2i,
	_allegiance: Utils.Allegiance,
	_first_move: bool = false,
) -> Dictionary:
	push_error("Using base behaviour")
	assert(false)
	return {}


func add_moves_in_direction(
	coords: Vector2i,
	moves: Array[Vector2i],
	takes: Dictionary,
	allegiance: Utils.Allegiance,
	delta: Vector2i,
	once: bool = false,
	) -> void:
	while true:
		coords += delta
		if not Utils.is_within_bounds(coords):
			return
		var enemy: Piece = Utils.is_enemy(coords, allegiance)
		if Utils.is_empty(coords):
			moves.append(coords)
		elif enemy:
			takes[coords] = enemy
			return
		else:
			return
		if once:
			return
