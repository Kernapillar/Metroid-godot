extends CharacterBody2D

var direction: Vector2
var speed = 50

func _physics_process(_delta):
	if Input.is_action_pressed("right"): 
		direction = Vector2.RIGHT
		velocity = direction * speed
		move_and_slide()
		
