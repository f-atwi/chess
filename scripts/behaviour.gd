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


func add_moves_in_direction(coords: Vector2i, moves: Dictionary, allegiance: Utils.Allegiance, delta: Vector2i) -> void:
	while true:
		coords += delta
		if not Utils.is_within_bounds(coords):
			return
		if Utils.is_empty(coords):
			moves["moves"].append(coords)
		elif Utils.is_enemy(coords, allegiance):
			moves["takes"].append(coords)
			return
		else:
			return
