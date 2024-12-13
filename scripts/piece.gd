extends Sprite2D

@onready var board: TileMapLayer = $"../../board"

enum Piece {pawn, rook, knight, bishop, queen, king}
enum Allegiance {white, black}

const TILE_SIZE = 32
const TEXTURE_PATH = "res://assets/{color}_{piece_type}.png"
@export var piece_type: Piece = Piece.pawn
var _get_valid_moves: Callable
var allegiance: Allegiance = Allegiance.white


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	allegiance = Allegiance.get(get_parent().name)
	if allegiance == Allegiance.black:
		rotate(PI)
	texture = load(_get_texture_path(TEXTURE_PATH))
	match piece_type:
		Piece.pawn:
			_get_valid_moves = _get_valid_pawn_moves
	board_position = Vector2i(5, 5)
	_get_valid_moves.call()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _get_texture_path(texture_format: String) -> String:
	return texture_format.format({
		"color": get_parent().name,
		"piece_type": Piece.find_key(piece_type)
	})


func _move_to_position(pos: String) -> void:
	position = _from_position(pos)


func _from_position(pos: String) -> Vector2:
	var row: int = pos.unicode_at(0) - "a".unicode_at(0)
	var col: int = int(pos[1]) - 1
	return Vector2(row*TILE_SIZE, -col*TILE_SIZE)


func _get_chess_position() -> String:
	return char(int(position.x/TILE_SIZE) + "a".unicode_at(0))+ str(int(-position.y/TILE_SIZE)+1)


func _move_from_row_relative(row: String, step: int) -> String:
	var new_pos := int(row) -1  + step
	assert(new_pos >=0 and new_pos <= 7)
	return str(new_pos)


func _move_from_col_relative(col: String, step: int) -> String:
	var new_pos := col.unicode_at(0) - "a".unicode_at(0) + step
	assert( new_pos >=0 and new_pos <= 7)
	return char(new_pos + "a".unicode_at(0) )


func _move_relative(pos: String, step_col: int, step_row: int)-> String:
	return _move_from_col_relative(pos[0], step_col)+_move_from_row_relative(pos[1], step_row)


func _get_valid_pawn_moves() -> void:
	print(board_position)


var board_position : Vector2i :
	set(value):
		board_position = value
		value.y *= -1
		position = board.map_to_local(value)
	get:
		if board_position:
			return board_position
		var pos := board.local_to_map(position)
		pos.y *= -1
		return pos


func _get_board_position() -> Vector2i:
	var pos := board.local_to_map(position)
	pos.y *= -1
	return pos


func _get_chess_notation(pos : Vector2i) -> String:
	return char(pos.x + "a".unicode_at(0)) + str(pos.y + 1) 
