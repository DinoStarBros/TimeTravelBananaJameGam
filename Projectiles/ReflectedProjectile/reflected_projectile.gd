extends Projectile
class_name ReflectedProjectile

var direction : Vector2

func _ready() -> void:
	%Reflect.pitch_scale += randf_range(-.2, .2)
	velocity = direction * 1000
	await get_tree().process_frame
	_spawn_click_boom()
	
	Global.add_score(40, global_position)
	Global.spawn_splash_txt(global_position, 0.7, "Parry!")

func _physics_process(delta: float) -> void:
	_move(delta)

func _spawn_click_boom() -> void:
	var click_boom : ClickBoom = References.click_boom_scn.instantiate()
	Global.arena.add_child(click_boom)
	click_boom.global_position = global_position
	#click_boom.scale = Vector2(5,5)
	#click_boom.modulate = Color.ORANGE_RED


func _on_life_timer_timeout() -> void:
	queue_free()
