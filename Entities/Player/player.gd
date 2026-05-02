extends CharacterBody2D
class_name Player

@export var x_speed : float = 400
@export var jump_speed : float = 600
@export var dash_speed : float = 1200

@onready var sprite: Sprite2D = %Mow
@onready var state_machine: StateMachine = %StateMachine

var x_input : int = 0
var last_x_input : int = 1
var override_flip_sprite : bool = false
var jump_buffer_time : float = 0
var enable_gravity : bool = true
var coyote_time : float = 0
var time_since_dash : float = 0

const dash_duration : float = 0.17
const dash_cooldown : float = 0.3

func _ready() -> void:
	Global.player = self

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if enable_gravity:
			if velocity.y < 0:
				velocity.y += get_gravity().y * delta
			else:
				velocity.y += get_gravity().y * delta * 1.8
		coyote_time += delta
		
		velocity.y = min(velocity.y, Global.FALL_SPD_LIMIT)
		
	else:
		coyote_time = 0
	
	_x_input_handling()
	move_and_slide()
	
	time_since_dash = min(time_since_dash + delta, 3)

func x_move_handling() -> void:
	velocity.x = x_input * x_speed

func dash_handling() -> void:
	if Input.is_action_just_pressed("dash") and time_since_dash >= dash_cooldown:
		state_machine.change_state("dash")

func reset_sprite_flip_gravity() -> void:
	enable_gravity = true
	override_flip_sprite = false

func _x_input_handling() -> void:
	if Input.is_action_pressed("right"):
		x_input = 1
		last_x_input = 1
	elif Input.is_action_pressed("left"):
		x_input = -1
		last_x_input = -1
	else:
		x_input = 0
	
	if not override_flip_sprite:
		sprite.flip_h = last_x_input == -1
