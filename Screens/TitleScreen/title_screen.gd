extends Control
class_name TitleScreen

@onready var bgs: Node2D = %BGs
@onready var bg_stuff : Array =[
	%bg1,%bg2,%bg3,%bg4
]

var bg_vel : Vector2
var speed_mult : float = 2


func _ready() -> void:
	%play.pressed.connect(_play_pressed)
	%quit.pressed.connect(_quit_pressed)
	get_tree().paused = false
	Global.current_game_state = Global.game_states.TITLE
	
	bg_vel = Vector2(-100, -100) * speed_mult

func _play_pressed() -> void:
	SceneManager.change_scene("res://Screens/Arena/arena.tscn")

func _quit_pressed() -> void:
	get_tree().quit()

func _physics_process(delta: float) -> void:
	
	bgs.global_position += delta * bg_vel * Vector2(640, 360).direction_to(get_global_mouse_position())
	
	for bg in bg_stuff:
		bg.global_position.x = wrapf(bg.global_position.x, -2048, 2048)
		bg.global_position.y = wrapf(bg.global_position.y, -1536, 1536)
	#print(%bg1.global_position.x)
