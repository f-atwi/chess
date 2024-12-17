class_name Piece
extends Sprite2D


const TEXTURE_PATH = "res://assets/{color}_{piece_type}.png"
const BEHAVIOUR_SCRIPTS = {
	Utils.Type.PAWN: preload("res://scripts/pawn_behaviour.gd"),
	Utils.Type.ROOK: preload("res://scripts/rook_behaviour.gd"),
	Utils.Type.KNIGHT: preload("res://scripts/knight_behaviour.gd"),
	Utils.Type.BISHOP: preload("res://scripts/bishop_behaviour.gd"),
	Utils.Type.QUEEN: preload("res://scripts/queen_behaviour.gd"),
	Utils.Type.KING: preload("res://scripts/king_behaviour.gd"),
}

@export var piece_type: Utils.Type = Utils.Type.PAWN
@export_group("Initial Position")
@export_range(0, 7) var initial_position_x: int
@export_range(0, 7) var initial_position_y: int


var position_board: Vector2i:
	set(value):
		position_board = value
		position = board.map_to_local(value)

var _allegiance: Utils.Allegiance = Utils.Allegiance.WHITE
var _first_move := true
var _selected := false

var behaviour: Behaviour

@onready var board: TileMapLayer = $"../.."


func _ready() -> void:
	position_board = Vector2i(initial_position_board.x, -initial_position_board.y)
	_allegiance = Utils.Allegiance.get(get_parent().name.to_upper())
	if board.rotate_black and _allegiance == Utils.Allegiance.BLACK:
		rotate(PI)
	texture = load(_get_texture_path(TEXTURE_PATH))
	_get_behaviour()


func _process(delta: float) -> void:
	pass


func _get_texture_path(texture_format: String) -> String:
	return texture_format.format({
		"color": get_parent().name.to_lower(),
		"piece_type": Utils.Type.find_key(piece_type).to_lower()
	})


func _move_from_col_relative(col: String, step: int) -> String:
	var new_pos := col.unicode_at(0) - "a".unicode_at(0) + step
	assert(new_pos >= 0 and new_pos <= 7)
	return char(new_pos + "a".unicode_at(0))


func to_chess_notation(pos: Vector2i) -> String:
	return char(pos.x + "a".unicode_at(0)) + str(pos.y + 1)


func _get_behaviour() -> void:
	behaviour = BEHAVIOUR_SCRIPTS[piece_type].new()


func select() -> void:
	if _selected:
		board.unhighlight()
	else:
		board.highlight_piece(position_board)
		var moves := behaviour.get_valid_moves(position_board, _allegiance, _first_move)
		for tile: Vector2i in moves["moves"]:
			board.highlight_move(tile)
		for tile: Vector2i in moves["takes"]:
			board.highlight_take(tile)
		
	_selected = not _selected
