extends Node

enum OccupancyState {EMPTY, WHITE=-1, BLACK=1}

var occupancy_grid: Dictionary = {}

func _ready() -> void:
	init_occupancy_grid()

func init_occupancy_grid():
	for i in range(8):
		for j in range(8):
			occupancy_grid[Vector2i(i, -j)] = OccupancyState.EMPTY


func move_piece(from: Vector2i, to: Vector2i):
	assert(occupancy_grid[from] != OccupancyState.EMPTY)
	assert(occupancy_grid[to] == OccupancyState.EMPTY or occupancy_grid[to] != occupancy_grid[from])

	occupancy_grid[to] = occupancy_grid[from]
	occupancy_grid[from] = OccupancyState.EMPTY
	

func is_empty(coords: Vector2i) -> bool:
	return occupancy_grid[coords] == OccupancyState.EMPTY


func is_within_bounds(coords: Vector2i) -> bool:
	return (
		coords.x >= 0
		and coords.x <= 7
		and coords.y <= 0
		and coords.y >= -7
	)

func is_enemy(coords: Vector2i, allegiance: int) -> bool:
	# TODO: fix allegiance type ( i dont like it)
	return occupancy_grid[coords] and allegiance != occupancy_grid[coords]
