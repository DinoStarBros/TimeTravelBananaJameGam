extends State

func enter() -> void:
	state_duration = p.rewind_duration
	p.velocity = Vector2.ZERO
	p.enable_gravity = false
	p.hurtbox.disabled = true

func physics_update(delta: float) -> void:
	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0: pass

func exit() -> void:
	p.hurtbox.disabled = false
