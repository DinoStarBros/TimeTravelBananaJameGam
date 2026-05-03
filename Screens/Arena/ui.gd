extends CanvasLayer
class_name ArenaUI

@onready var time_p_txt: Label = %time_p_txt

func _ready() -> void:
	Global.time_passed = 0

func _physics_process(delta: float) -> void:
	Global.time_passed += delta
	time_p_txt.text = str(get_clean_time(Global.time_passed))

func get_clean_time(time_passed: float) -> String:
	var minutes = int(time_passed / 60)
	var seconds = int(time_passed) % 60
	var centiseconds = int(fmod(time_passed, 1) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, centiseconds]
