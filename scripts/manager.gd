extends Node2D

const TILE_SIZE = 32

@onready var black: Node2D = $board/Back
@onready var white: Node2D = $board/White

var turn := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
