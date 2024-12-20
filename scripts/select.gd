extends Node


@onready var state: Node = %State
@onready var board: TileMapLayer = %Board


func handle_actions(action: Utils.Action, params: Dictionary) -> void:
	match action:
		Utils.Action.SELECT:
			board.select(params)
			state.set_state("Move")
