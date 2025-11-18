extends CharacterBody2D

var target = null
var speed = 80
var health = 3
var exploding = false

func _ready():
	$AnimatedSprite2D.material = $AnimatedSprite2D.material.duplicate()

func _physics_process(_delta):
	if target: 
		velocity = position.direction_to(target.position) * speed 
	else: 
		velocity = Vector2.ZERO
	move_and_slide()

func take_damage(value): 
	health -= value
	if health <= 0: 
		explode()
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D.material, 'shader_parameter/Progress', 0.0, 0.3)
	tween.tween_property($AnimatedSprite2D.material, 'shader_parameter/Progress', 1.0, 0.5)
	
		

func explode(): 
	speed = 0
	exploding = true
	$explosion.visible = true
	$AnimatedSprite2D.visible = false
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("explosion")
	await $AnimationPlayer.animation_finished
	queue_free()
	
	
func explosion_damage(): 
	for entity in get_tree().get_nodes_in_group("entities"): 
		if position.distance_to(entity.position) < 50 and "take_damage" in entity and not entity.exploding: 
			entity.take_damage(3)

#func chain_reaction(): 
	#for drone in get_tree().get_nodes_in_group("drones"): 
		#if position.distance_to(drone.position) < 50: 
			#print(drone)
			#drone.explode()
	
	

func _on_aggro_radius_body_entered(body):
	if body.name == "Player": 
		target = body



func _on_aggro_radius_body_exited(body):
	if body.name == "Player": 
		target = null


func _on_damage_radius_body_entered(body):
	if body.name == "Player": 
		explode()
