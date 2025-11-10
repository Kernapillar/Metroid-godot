extends Area2D

var direction: Vector2
var speed = 200

func setup(pos: Vector2, dir: Vector2): 
	position = pos + dir * 15
	direction = dir
	
func _physics_process(delta):
	position += direction * speed * delta
