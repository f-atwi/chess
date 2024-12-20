extends Node

enum Type {PAWN, ROOK, KNIGHT, BISHOP, QUEEN, KING}
enum OccupancyState {EMPTY, WHITE=-1, BLACK=1}
enum Allegiance {
	WHITE=OccupancyState.WHITE,
	BLACK=OccupancyState.BLACK,
}
enum Action {SELECT, MOVE, TAKE}

var occupancy_grid: Dictionary = {}

func _ready() -> void:
	init_occupancy_grid()

func init_occupancy_grid() -> void:
	for i in range(8):
		for j in range(8):
			occupancy_grid[Vector2i(i, -j)] = null


func move_piece(from: Vector2i, to: Vector2i) -> void:
	assert(occupancy_grid[from])
	assert(
		not occupancy_grid[to]
		or occupancy_grid[to] != occupancy_grid[from]
	)

	occupancy_grid[to] = occupancy_grid[from]
	occupancy_grid[from] = null
	

func is_empty(coords: Vector2i) -> bool:
	return not occupancy_grid[coords]


func is_within_bounds(coords: Vector2i) -> bool:
	return (
		coords.x >= 0
		and coords.x <= 7
		and coords.y <= 0
		and coords.y >= -7
	)

func is_enemy(coords: Vector2i, allegiance: Allegiance) -> Piece:
	if occupancy_grid[coords] and occupancy_grid[coords]._allegiance != allegiance:
		return occupancy_grid[coords]
	return null


func to_chess_notation(pos: Vector2i) -> String:
	return char(pos.x + "a".unicode_at(0)) + str(pos.y + 1)
