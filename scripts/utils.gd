extends Node

func is_within_bounds(coords: Vector2i) -> bool:
	return (
		coords.x >= 0
		and coords.x <= 7
		and coords.y <= 0
		and coords.y >= -7
	)
