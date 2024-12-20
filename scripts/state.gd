extends Node


signal trigger_action(action: Utils.Action)

var current_state: Node


func _ready() -> void:
	set_state("Select")


func set_state(state_name: String) -> void:
	print(state_name)
	if current_state:
		if current_state.name == state_name:
			return
		trigger_action.disconnect(current_state.handle_actions)
	current_state = get_node(state_name)
	trigger_action.connect(current_state.handle_actions, )
