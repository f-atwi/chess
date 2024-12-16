extends Area2D


func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_action_released("click"):
		get_parent().select()
		
