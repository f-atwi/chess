extends TileMapLayer

const BLACK_TILE_ATLAS = Vector2i(0, 1)
const WHITE_TILE_ATLAS = Vector2i(1, 1)
const HIGHLIGHT_MOVE_ATLAS = Vector2i(2, 1)
const HIGHLIGHT_TAKE_ATLAS = Vector2i(1, 2)
const HIGHLIGHT_CHECK_ATLAS = Vector2i(2, 2)
const HIGHLIGHT_PIECE_ATLAS = Vector2i(0, 2)

@export var rotate_black := false

var turn := true
var highlighted: Array[Vector2i] = []

@onready var black: Node = $Black
@onready var white: Node = $White


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while Utils.occupancy_grid.size() != 64:
		pass
	var pieces: Array[Piece]
	pieces.assign(black.get_children())
	for piece in pieces:
		Utils.occupancy_grid[piece.position_board] = Utils.OccupancyState.BLACK
	pieces.assign(white.get_children())
	for piece in pieces:
		Utils.occupancy_grid[piece.position_board] = Utils.OccupancyState.WHITE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _set_tile(coords: Vector2i, atlas: Vector2i) -> void:
	set_cell(coords, 1, atlas)


func highlight_move(coords: Vector2i) -> void:
	highlighted.append(coords)
	_set_tile(coords, HIGHLIGHT_MOVE_ATLAS)


func highlight_take(coords: Vector2i) -> void:
	highlighted.append(coords)
	_set_tile(coords, HIGHLIGHT_TAKE_ATLAS)


func highlight_check(coords: Vector2i) -> void:
	highlighted.append(coords)
	_set_tile(coords, HIGHLIGHT_CHECK_ATLAS)


func highlight_piece(coords: Vector2i) -> void:
	highlighted.append(coords)
	_set_tile(coords, HIGHLIGHT_PIECE_ATLAS)


func unhighlight_tile(coords: Vector2i) -> void:
	_set_tile(coords, _get_original_tile(coords))


func unhighlight() -> void:
	for tile in highlighted:
		unhighlight_tile(tile)


func _get_original_tile(coords: Vector2i) -> Vector2i:
	if coords.x % 2 == -coords.y % 2:
		return BLACK_TILE_ATLAS
	return WHITE_TILE_ATLAS


func _is_empty(coords: Vector2i) -> bool:
	# TODO: optimize
	var pieces := (black.get_children() + white.get_children()) as Array[Piece]
	for piece in pieces:
		if piece.position_board == coords:
			return false
	return true
