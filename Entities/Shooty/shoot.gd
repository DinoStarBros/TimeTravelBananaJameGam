extends State

#p.get_dir_to_plr()
#p.get_dist_to_plr()

func enter() -> void:
	state_duration = p.attack_duration
	_spawn_bullet()
	
	%shotSfx.pitch_scale += randf_range(-.2,.2)
	%shotSfx.play(.08)

func physics_update(delta: float) -> void:
	state_duration = max(0, state_duration-delta)
	if state_duration <= 0:
		state_machine.change_state("Walk")

func _spawn_bullet() -> void:
	var bullet_scn : EnemyProjectile = References.enemy_projectile_scn.instantiate()
	bullet_scn.direction = p.get_dir_to_plr()
	Global.arena.add_child(bullet_scn)
	bullet_scn.global_position = p.global_position
	
