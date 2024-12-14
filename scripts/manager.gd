extends Node2D

const TILE_SIZE = 32

@onready var board: TileMapLayer = %Board
@onready var black: Node2D = $Board/Black
@onready var white: Node2D = $Board/White

var turn := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func highlight_tile(coords: Vector2i) -> void:
	board.set_cell(board_to_map(coords), 1, Vector2i(2, 1))
	
func board_to_map(coords_board: Vector2i) -> Vector2i:
	coords_board.y = -coords_board.y + 1
	return coords_board

func map_to_board(coords_map: Vector2i) -> Vector2i:
	coords_map.y = -coords_map.y - 1
	return coords_map
