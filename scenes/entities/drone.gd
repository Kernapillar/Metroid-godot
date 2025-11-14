extends CharacterBody2D

var target = null
var speed = 80
var health = 3
var exploding = false

func _physics_process(_delta):
	if not exploding: 
		$AnimationPlayer.play("flying")
	if target: 
		velocity = position.direction_to(target.position) * speed 
	else: 
		velocity = Vector2.ZERO
	move_and_slide()

func take_damage(_value): 
	health -= 1
	if health <= 0: 
		explode()
		

func explode(): 
	speed = 0
	exploding = true
	$explosion.visible = true
	$Sprite2D.visible = false
	$AnimationPlayer.play("explosion")
	await $AnimationPlayer.animation_finished
	queue_free()
	
func chain_reaction(): 
	for drone in get_tree().get_nodes_in_group("drones"): 
		if position.distance_to(drone.position) < 50: 
			print(drone)
			drone.explode()
	
	

func _on_aggro_radius_body_entered(body):
	if body.name == "Player": 
		print("targeting")
		target = body



func _on_aggro_radius_body_exited(body):
	if body.name == "Player": 
		target = null


func _on_damage_radius_body_entered(body):
	if body.name == "Player": 
		explode()
