extends KinematicBody2D

class_name Pawn

var velocity : Vector2 = Vector2.ZERO
export var gravity : float = 3000.0

export var speed : Vector2 = Vector2(300,300)
export var jump_speed : float = 5
export var max_fall_speed : float = 1000.0


func _physics_process(delta: float)-> void:
	#velocity.y += gravity*delta
	#velocity.y = max(velocity.y,max_fall_speed)
	return 
	
