extends Pawn

export var stomp_impulse: float = 1000

func _physics_process(delta: float)-> void:
	
	var is_jump_interrupted := Input.is_action_just_released("jump") and velocity.y < 0.0
	
	var direction = get_direction()
	
	
	velocity = calculate_move_velocity(velocity,direction,speed,is_jump_interrupted)
	
	velocity = move_and_slide(velocity,Vector2.UP)
	return



func get_direction() -> Vector2:
	var desired_speed = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	var direction = Vector2(desired_speed , get_vertical_speed())
	return direction

func get_vertical_speed() -> float:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		return -1.0
	return 1.0


func calculate_move_velocity(
		linear_velocity : Vector2,
		direction : Vector2,
		speed : Vector2 ,
		is_jump_interrupted : bool
	) -> Vector2:	
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	if is_jump_interrupted :
		new_velocity.y = 0 		
	elif(direction.y == -1):
		new_velocity.y = speed.y * direction.y
	else:
		new_velocity.y += gravity * get_physics_process_delta_time()	
	
	return new_velocity

func calculate_stomp_velocity(
		linear_velocity : Vector2,
		impulse : float)-> Vector2:	
	var out : = linear_velocity
	out.y = -impulse
	
	return out

func _on_EnemyDetector_area_entered(area):	
	if area.global_position.y < get_node("EnemyDetector").global_position.y :
		return
	velocity = calculate_stomp_velocity(velocity,stomp_impulse)


func _on_EnemyDetector_body_entered(body):
	queue_free()
