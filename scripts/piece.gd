extends Sprite2D

enum Type {PAWN, ROOK, KNIGHT, BISHOP, QUEEN, KING}
enum Allegiance {WHITE=1, BLACK=-1}

const TEXTURE_PATH = "res://assets/{color}_{piece_type}.png"
const BEHAVIOUR_SCRIPTS = {
	Type.PAWN: preload("res://scripts/pawn_behaviour.gd"),
	Type.ROOK: preload("res://scripts/rook_behaviour.gd"),
	Type.KNIGHT: preload("res://scripts/knight_behaviour.gd"),
	Type.BISHOP: preload("res://scripts/bishop_behaviour.gd"),
	Type.QUEEN: preload("res://scripts/queen_behaviour.gd"),
	Type.KING: preload("res://scripts/king_behaviour.gd"),
}

@export var piece_type: Type = Type.PAWN
@export var initial_position_board: Vector2i

var position_board: Vector2i:
	set(value):
		position_board = value
		value.y = -value.y - 1
		position = board.map_to_local(value)

var _allegiance: Allegiance = Allegiance.WHITE
var _first_move := true

var behaviour: Behaviour

@onready var board: TileMapLayer = $"../.."


func _ready() -> void:
	position_board = initial_position_board
	_allegiance = Allegiance.get(get_parent().name.to_upper())
	if _allegiance == Allegiance.BLACK:
		rotate(PI)
	texture = load(_get_texture_path(TEXTURE_PATH))
	_get_behaviour()


func _process(delta: float) -> void:
	pass

func _get_texture_path(texture_format: String) -> String:
	return texture_format.format({
		"color": get_parent().name.to_lower(),
		"piece_type": Type.find_key(piece_type).to_lower()
	})


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


func _get_behaviour() -> void:
	behaviour = BEHAVIOUR_SCRIPTS[piece_type].new()


func select() -> void:
	board.highlight_tile(position_board)
