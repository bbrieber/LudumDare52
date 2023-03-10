extends Pawn


func _ready():
	set_physics_process(false)
	velocity.x = - speed.x
	
func _on_StompDetector_body_entered(body):
	if body.global_position.y > get_node("StompDetector").global_position.y :
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()
	
	
	
func _physics_process(delta):
	if is_on_wall():
		velocity.x *= -1.0

	velocity.y = move_and_slide(velocity,Vector2.UP).y


