extends CharacterBody2D
class_name Player

@export var x_speed : float = 400
@export var jump_speed : float = 600
@export var dash_speed : float = 1200
@export var slash_speed : float = 350
@export var boomerang_throw_recoil : float = 500
@export var bananarang_speed : float = 1000
@export var banana_throw_chrono_req : int = 1
@export var rewind_ult_chrono_req : int = 10
@export var rewind_time_seconds_past : float = 2

@onready var sprite: Sprite2D = %Mow
@onready var state_machine: StateMachine = %StateMachine
@onready var banana_pivot: Node2D = %banana_pivot
@onready var slash_anim: AnimationPlayer = %slash_anim
@onready var anim: AnimationPlayer = %anims
@onready var banana_sprite: Sprite2D = %banana
@onready var slash_sprite: Sprite2D = %slash_sprite
@onready var rang_charge_bar: ProgressBar = %rang_charge_bar
@onready var arrow: Sprite2D = %arrow
@onready var clock_juice: ClockJuice = %ClockJuice
@onready var hurtbox: CollisionShape2D = %hurtbox
@onready var slash_hitbox: HitboxComponent = %HitboxComponent
@onready var chrono_bar: ProgressBar = %chrono_bar
@onready var cm_text: Label = %cm_text
@onready var position_history_record: PositionHistoryRecord = %PositionHistoryRecord
@onready var position_history_trail: PositionHistoryTrail = %PositionHistoryTrail
@onready var outlines: Node2D = %outlines

var x_input : int = 0
var last_x_input : int = 1
var override_flip_sprite : bool = false
var jump_buffer_time : float = 0
var enable_gravity : bool = true
var coyote_time : float = 0
var time_since_dash : float = 0
var dir_to_mouse : Vector2
var time_since_slash : float = 0
var slash_mode : bool = false
var banan_desire_rot : float
var rang_charge : float = 0
var has_banana : float = true
var chronometer : int = 10:
	set(value):
		chronometer = clamp(value, 0, max_chronometer)
		

const max_chronometer : int = 30
const boomerang_throw_duration : float = 0.2
const dash_duration : float = 0.3
const dash_cooldown : float = 0.33
const slash_duration : float = 0.2
const slash_cooldown : float = 0.3
const rang_charge_time_slow : float = 0.5
const max_rang_charge : float = 0.3
const rewind_duration : float = 1

func _ready() -> void:
	Global.player = self
	Global.current_game_state = Global.game_states.COMBAT
	slash_hitbox.Hit.connect(func(attack:Attack): chronometer += 1)
	Global.score = 0

func _physics_process(delta: float) -> void:
	
	cm_text.text = str(
		chronometer, " / ", max_chronometer
	)
	chrono_bar.max_value = max_chronometer
	chrono_bar.value = chronometer
	
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
	banana_pivot_handling()
	move_and_slide()
	
	time_since_dash = min(time_since_dash + delta, 5)
	time_since_slash = min(time_since_slash + delta, 5)
	dir_to_mouse = global_position.direction_to(get_global_mouse_position())
	banana_sprite.rotation = lerp(banana_sprite.rotation, banan_desire_rot, 15.0 * delta)
	
	rang_charge_bar.max_value = max_rang_charge
	rang_charge_bar.value = rang_charge
	rang_charge_bar.visible = state_machine.current_state.name == "BoomerangCharge"
	
	_banana_rot_handle(delta)
	
	banana_pivot.visible = has_banana
	arrow.look_at(get_global_mouse_position())
	
	Global.past_sprite.global_position = position_history_record.get_position_from_past(rewind_time_seconds_past)

func _process(delta: float) -> void:
	if sprite.flip_h:
		outlines.scale.x = -1
	else:
		outlines.scale.x = 1

func x_move_handling(speed_mult : float = 1.0) -> void:
	velocity.x = x_input * x_speed * speed_mult

func dash_handling() -> void:
	if Input.is_action_just_pressed("dash") and time_since_dash >= dash_cooldown:
		state_machine.change_state("dash")
		
		%dash.pitch_scale = 1 + randf_range(-.1, .1)
		%dash.play()

func reset_sprite_flip_gravity() -> void:
	enable_gravity = true
	override_flip_sprite = false

func banana_pivot_handling() -> void:
	banana_pivot.look_at(get_global_mouse_position())

func slash_attack_handling() -> void:
	if !has_banana: return
	
	if Input.is_action_just_pressed("left_click") and time_since_slash >= slash_cooldown:
		state_machine.change_state("slashattack")
		
		%slash.pitch_scale = 1 + randf_range(-.2, .2)
		%slash.play()
		%slash2.pitch_scale = 0.8 + randf_range(-.2, .2)
		%slash2.play()
		
		slash_mode = !slash_mode
		slash_anim.play("slash")
		
		
		slash_sprite.flip_v = !slash_mode

func boomerang_handle(delta: float) -> void:
	if !has_banana: return
	
	if chronometer >= banana_throw_chrono_req:
	
		if Input.is_action_pressed("right_click"):
			state_machine.change_state("boomerangcharge")

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

func rewind_ult_handling() -> void:
	if not (chronometer >= rewind_ult_chrono_req):
		return
	
	if Input.is_action_just_pressed("r"):
		chronometer -= rewind_ult_chrono_req
		
		state_machine.change_state("Rewind")

func _banana_rot_handle(delta: float) -> void:
	if Input.is_action_pressed("right_click"):
		if slash_mode:
			banan_desire_rot = PI + deg_to_rad(20)
		else:
			banan_desire_rot = 0 - deg_to_rad(20)
		
		banana_sprite.position.x = randf_range(-10, 10)
		banana_sprite.position.y = randf_range(-10, 10)
		
	else:
		if slash_mode:
			banan_desire_rot = PI
		else:
			banan_desire_rot = 0
		
		banana_sprite.position = Vector2.ZERO
	
	banana_sprite.flip_h = slash_mode
