extends TileMapLayer


signal on_piece_clicked(piece: Piece)
signal on_mouse_click(coords: Vector2i)

const BLACK_TILE_ATLAS = Vector2i(0, 1)
const WHITE_TILE_ATLAS = Vector2i(1, 1)
const HIGHLIGHT_MOVE_ATLAS = Vector2i(2, 1)
const HIGHLIGHT_TAKE_ATLAS = Vector2i(1, 2)
const HIGHLIGHT_CHECK_ATLAS = Vector2i(2, 2)
const HIGHLIGHT_PIECE_ATLAS = Vector2i(0, 2)

@export var rotate_black := false

var turn := true
var highlighted: Array[Vector2i] = []
var selected: Piece = null

@onready var black: Node = $Black
@onready var white: Node = $White

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_action_released("click"):
		event = make_input_local(event)
		on_mouse_click.emit(local_to_map(event.position))


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while Utils.occupancy_grid.size() != 64:
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_process(false)
	await select()
	var valid := false
	while not valid:
		valid = await move_selected()
	unhighlight()
	highlighted.clear()
	selected = null
	set_process(true)
	pass


func select()-> void:
	selected = await on_piece_clicked
	var moves: Dictionary = selected.behaviour.get_valid_moves(
		selected.position_board,
		selected._allegiance,
		selected._first_move,
	)
	unhighlight()
	highlight_piece(selected.position_board)
	for tile: Vector2i in moves["moves"]:
		highlight_move(tile)
	for tile: Vector2i in moves["takes"]:
		highlight_take(tile)
	highlighted += moves["moves"] + moves["takes"]


func move_selected() -> bool:
	var coords: Vector2i = await on_mouse_click
	if coords in highlighted and coords != selected.position_board:
		Utils.move_piece(selected.position_board, coords) # Fix occpancy becomes empty when running over
		selected.move(coords)
		return true
	return false


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


func _set_tile(coords: Vector2i, atlas: Vector2i) -> void:
	set_cell(coords, 1, atlas)


func _get_original_tile(coords: Vector2i) -> Vector2i:
	if coords.x % 2 == -coords.y % 2:
		return BLACK_TILE_ATLAS
	return WHITE_TILE_ATLAS
