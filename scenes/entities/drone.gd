extends CharacterBody2D

var target = null
var speed = 80

func _physics_process(_delta):
	$AnimationPlayer.play("flying")
	if target: 
		velocity = position.direction_to(target.position) * speed 
	else: 
		velocity = Vector2.ZERO
	move_and_slide()
	animate_bobbing()
	
func animate_bobbing(): 
	var tween = get_tree().create_tween()
	#print("bobbing up")
	#tween.tween_property(self, "position:y", position.y - 3, 0.5)
	print("bobbing down")
	tween.tween_property(self, "position:y", position.y + 3, 0.3)


func _on_aggro_radius_body_entered(body):
	if body.name == "Player": 
		target = body
		


func _on_aggro_radius_body_exited(body):
	if body.name == "Player": 
		target = null
	
