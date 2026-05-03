extends Projectile
class_name Bananarang

var dir_to_plr : Vector2
var go_back : bool = false
var spd : float
var desire_vel : Vector2
var dist_to_plr : float

func _ready() -> void:
	%spin.play()
	%GoBackTimer.timeout.connect(func(): go_back=true)

func _physics_process(delta: float) -> void:
	_move(delta)
	%banana.rotation_degrees += 2000 * delta
	
	dir_to_plr = global_position.direction_to(Global.player.global_position)
	dist_to_plr = global_position.distance_to(Global.player.global_position)
	
	desire_vel = dir_to_plr * spd
	
	if go_back:
		spd += delta * 1000
		velocity = lerp(velocity, desire_vel, 8.0 * delta)
		if dist_to_plr <= 30:
			Global.player.has_banana = true
			queue_free()


func _on_hitbox_component_hit(attack: Attack) -> void:
	Global.add_score(10, global_position)
	Global.spawn_splash_txt(global_position, 0.5, "Bananarang")
