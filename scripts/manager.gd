extends TileMapLayer


const BLACK_TILE_ATLAS = Vector2i(0, 1)
const WHITE_TILE_ATLAS = Vector2i(1, 1)
const HIGHLIGHT_MOVE_ATLAS = Vector2i(2, 1)
const HIGHLIGHT_TAKE_ATLAS = Vector2i(1, 2)
const HIGHLIGHT_CHECK_ATLAS = Vector2i(2, 2)
const HIGHLIGHT_PIECE_ATLAS = Vector2i(0, 2)

@export var rotate_black := false

var turn := true
var highlighted_moves: Array[Vector2i] = []
var highlighted_takes: Dictionary = {}
var highlighted: Array[Vector2i] = []
var selected: Piece = null

@onready var black: Node = $Black
@onready var white: Node = $White
@onready var state: Node = %State

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_action_released("click"):
		event = make_input_local(event)
		state.trigger_action.emit(Utils.Action.MOVE, { "coords" :local_to_map(event.position) })


func _ready() -> void:
	while Utils.occupancy_grid.size() != 64:
		pass


func select(params: Dictionary) -> bool:
	if params["piece"].is_queued_for_deletion(): # is there a better way?
		return false
	unhighlight()
	if selected == params["piece"]:
		selected = null
		return false
	selected = params["piece"]
	var moves: Dictionary = selected.behaviour.get_valid_moves(
		selected.position_board,
		selected._allegiance,
		selected._first_move,
	)

	highlight_piece(selected.position_board)
	for tile: Vector2i in moves["moves"]:
		highlight_move(tile)
	for tile_pos: Vector2i in moves["takes"]:
		highlight_take(tile_pos, moves["takes"][tile_pos])
	highlighted_moves = moves["moves"]
	highlighted_takes = moves["takes"]
	return true


func move(params: Dictionary) -> void:
	var coords: Vector2i = params["coords"]
	if coords in highlighted_moves:
		Utils.move_piece(selected.position_board, coords)
		selected.move(coords)
	elif highlighted_takes.has(coords):
		highlighted_takes[coords].die()
		Utils.move_piece(selected.position_board, coords)
		selected.move(coords)


func highlight_move(coords: Vector2i) -> void:
	highlighted_moves.append(coords)
	_set_tile(coords, HIGHLIGHT_MOVE_ATLAS)


func highlight_take(coords: Vector2i, piece: Piece) -> void:
	highlighted_takes[coords] = piece
	_set_tile(coords, HIGHLIGHT_TAKE_ATLAS)


#func highlight_check(coords: Vector2i) -> void:
	#highlighted.append(coords)
	#_set_tile(coords, HIGHLIGHT_CHECK_ATLAS)


func highlight_piece(coords: Vector2i) -> void:
	highlighted.append(coords)
	_set_tile(coords, HIGHLIGHT_PIECE_ATLAS)


func unhighlight_tile(coords: Vector2i) -> void:
	_set_tile(coords, _get_original_tile(coords))


func unhighlight() -> void:
	for tile: Vector2i in highlighted:
		unhighlight_tile(tile)
	for tile: Vector2i in highlighted_moves:
		unhighlight_tile(tile)
	for tile: Vector2i in highlighted_takes.keys():
		unhighlight_tile(tile)
	highlighted.clear()
	highlighted_moves.clear()
	highlighted_takes.clear()


func _set_tile(coords: Vector2i, atlas: Vector2i) -> void:
	set_cell(coords, 1, atlas)


func _get_original_tile(coords: Vector2i) -> Vector2i:
	if coords.x % 2 == -coords.y % 2:
		return BLACK_TILE_ATLAS
	return WHITE_TILE_ATLAS
