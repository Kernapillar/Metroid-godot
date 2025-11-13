extends Area2D

var direction: Vector2
var speed = 250

func setup(pos: Vector2, dir: Vector2): 
	position = pos + dir * 15
	direction = dir
	
func _physics_process(delta):
	position += direction * speed * delta
func _ready(): 
	#$Sprite2D.scale = Vector2.ZERO
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(1, 1), 0.3).from(Vector2.ZERO)
