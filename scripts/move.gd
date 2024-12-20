extends Node


@onready var state: Node = %State
@onready var board: TileMapLayer = %Board


func handle_actions(action: Utils.Action, params: Dictionary) -> void:
	match action:
		Utils.Action.SELECT:
			if not board.select(params):
				state.set_state("Select")
		Utils.Action.MOVE:
			board.move(params)
			state.set_state("Select")
