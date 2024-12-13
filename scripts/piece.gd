class_name Piece
extends Sprite2D

enum Type {PAWN, ROOK, KNIGHT, BISHOP, QUEEN, KING}
enum Allegiance {WHITE=1, BLACK=-1}

const TILE_SIZE = 32
const TEXTURE_PATH = "res://assets/{color}_{piece_type}.png"
const SCRIPTS := {
	Type.PAWN: preload("res://scripts/pawn.gd"),
	Type.ROOK: preload("res://scripts/rook.gd"),
	Type.KNIGHT: preload("res://scripts/knight.gd"),
	Type.BISHOP: preload("res://scripts/bishop.gd"),
	Type.QUEEN: preload("res://scripts/queen.gd"),
	Type.KING: preload("res://scripts/king.gd"),
}

@export var piece_type: Type = Type.PAWN
@export var initial_board_position: Vector2i

var board_position: Vector2i:
	set(value):
		board_position = value
		value.y = -value.y - 1
		position = board.map_to_local(value)
	get:
		if board_position:
			return board_position
		var pos := board.local_to_map(position)
		pos.y *= -1
		return pos

var _allegiance: Allegiance = Allegiance.WHITE
var _first_move := true

@onready var board: TileMapLayer = $"../.."


func _ready() -> void:
	board_position = initial_board_position
	_allegiance = Allegiance.get(get_parent().name.to_upper())
	if _allegiance == Allegiance.BLACK:
		rotate(PI)
	texture = load(_get_texture_path(TEXTURE_PATH))
	_assign_script_based_on_type()


func _process(delta: float) -> void:
	pass

func _get_texture_path(texture_format: String) -> String:
	return texture_format.format({
		"color": get_parent().name.to_lower(),
		"piece_type": Type.find_key(piece_type).to_lower()
	})


func _move_to_position(pos: String) -> void:
	position = _from_position(pos)


func _from_position(pos: String) -> Vector2:
	var row: int = pos.unicode_at(0) - "a".unicode_at(0)
	var col: int = int(pos[1]) - 1
	return Vector2(row * TILE_SIZE, -col * TILE_SIZE)


func _move_from_row_relative(row: String, step: int) -> String:
	var new_pos := int(row) - 1 + step
	assert(new_pos >= 0 and new_pos <= 7)
	return str(new_pos)


func _move_from_col_relative(col: String, step: int) -> String:
	var new_pos := col.unicode_at(0) - "a".unicode_at(0) + step
	assert(new_pos >= 0 and new_pos <= 7)
	return char(new_pos + "a".unicode_at(0))


func _move_relative(pos: String, step_col: int, step_row: int) -> String:
	return _move_from_col_relative(pos[0], step_col) + _move_from_row_relative(pos[1], step_row)


func to_chess_notation(pos: Vector2i) -> String:
	return char(pos.x + "a".unicode_at(0)) + str(pos.y + 1)
	
func _assign_script_based_on_type() -> void:
	self.set_script(SCRIPTS[piece_type])
