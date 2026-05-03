extends CanvasLayer

@onready var screenim: AnimationPlayer = %screenim
@onready var plr_dead: Control = %PlrDead
@onready var health_component: HealthComponent = %HealthComponent
@onready var score_count: Label = %score_count

var died : bool = false
var darken_desire_col : Color = Color.WHITE
var lerped_score : float 

func _ready() -> void:
	get_tree().paused = false
	plr_dead.hide()
	health_component.Dead.connect(_dead)

func _input(event: InputEvent) -> void:
	
	if died:
		if Input.is_action_just_pressed("enter"):
			_reload_scene()

func _dead() -> void:
	died = true
	plr_dead.show()

func _reload_scene() -> void:
	plr_dead.hide()
	
	screenim.play("rewind")
	await get_tree().create_timer(0.4).timeout
	SceneManager.reload_scene()

func _process(delta: float) -> void:
	lerped_score = lerp(lerped_score, float(Global.score), 8.0 * delta)
	
	score_count.text = str(
		"Score : ", roundi(lerped_score)
	)
	
