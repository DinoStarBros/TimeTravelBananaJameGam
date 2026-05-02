extends Node2D
class_name PositionHistoryRecord

var position_history: Array[Vector2] = []
var history_timestamps: Array[float] = []
var max_history_seconds: float = 5.0

func _process(delta: float) -> void:
	var parent = get_parent()
	if parent.has_method("get_global_position"):
		_record_position(parent.get_global_position())

func _record_position(pos: Vector2) -> void:
	position_history.append(pos)
	history_timestamps.append(Time.get_ticks_msec() / 1000.0)
	
	var cutoff = (Time.get_ticks_msec() / 1000.0) - max_history_seconds
	while history_timestamps.size() > 0 and history_timestamps[0] < cutoff:
		position_history.pop_front()
		history_timestamps.pop_front()

func get_position_from_past(seconds_ago: float) -> Vector2:
	var target_time = (Time.get_ticks_msec() / 1000.0) - seconds_ago
	
	for i in range(history_timestamps.size() - 1, -1, -1):
		if history_timestamps[i] <= target_time:
			return position_history[i]
	
	return position_history[0] if position_history.size() > 0 else Vector2.ZERO
