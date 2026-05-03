extends CanvasLayer
class_name ArenaUI

@onready var time_p_txt: Label = %time_p_txt

func _ready() -> void:
	Global.time_passed = 0

func _physics_process(delta: float) -> void:
	Global.time_passed += delta
	time_p_txt.text = str(Global.time_passed)
