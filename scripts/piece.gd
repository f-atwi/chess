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

var behaviour: Behaviour

@onready var board: TileMapLayer = %Board


func _ready() -> void:
	position_board = Vector2i(initial_position_x, -initial_position_y)
	_allegiance = Utils.Allegiance.get(get_parent().name.to_upper())
	if board.rotate_black and _allegiance == Utils.Allegiance.BLACK:
		rotate(PI)
	_load_texture()
	_get_behaviour()
	Utils.occupancy_grid[position_board] = self


func move(coords: Vector2i) -> void:
	_first_move = false
	position_board = coords


func die() -> void:
	queue_free()


func _load_texture() -> void:
	texture = load(TEXTURE_PATH.format({
		"color": get_parent().name.to_lower(),
		"piece_type": Utils.Type.find_key(piece_type).to_lower()
	}))


func _get_behaviour() -> void:
	behaviour = BEHAVIOUR_SCRIPTS[piece_type].new()
