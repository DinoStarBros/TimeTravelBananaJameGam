## Just a place to store all the scaling functions that'll be used 
## for stuff like stats
class_name Scalings
extends RefCounted

## Linear scaling function, just multiply it with a value you want scaled
## with a value and strength
static func linear_scaling(
	level : float,
	scaling_strength: float,
	increase_or_decrease: bool = true
	) -> float:
	
	if increase_or_decrease:
		return (1 + (level * scaling_strength) / (10))
	else:
		return (1 - (level * scaling_strength) / (10))

## Exponential scaling function, just multiply it with a value you want scaled
## with a value and strength
static func exp_scaling(
	level : float,
	scaling_strength: float,
	increase_or_decrease: bool = true
	) -> float:
	
	if increase_or_decrease:
		return exp(level * scaling_strength)
	else:
		return exp(-level * scaling_strength * 0.1)

## Logarithmic scaling function, just multiply it with a value you want scaled
## with a value and strength
static func log_scaling(
	level : float,
	scaling_strength: float,
	increase_or_decrease: bool = true
	) -> float:
	
	if increase_or_decrease:
		return 1.0 + (scaling_strength * log(1.0 + level))
	else:
		return max(0.1, 1.0 - (scaling_strength * log(1.0 + level) * 0.1))

## Quadratic scaling function, just multiply it with a value you want scaled
## with a value and strength
static func quad_scaling(
	level : float,
	scaling_strength: float,
	increase_or_decrease: bool = true
	) -> float:
	
	if increase_or_decrease:
		return 1.0 + (scaling_strength * pow(level, 2))
	else:
		return max(0.1, 1.0 - (scaling_strength * pow(level, 2) * 0.01))
