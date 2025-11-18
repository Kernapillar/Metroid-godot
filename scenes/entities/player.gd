extends CharacterBody2D

var direction_x: float
var speed = 120
@export var gravity = 10
@export var jump_strength = 10
signal shoot(pos: Vector2, dir: Vector2)
var aim_directions = {
	"(1, 0)": 0, 
	"(1, 1)": 1, 
	"(0, 1)": 2, 
	"(-1, 1)": 3, 
	"(-1, 0)": 4, 
	"(-1, -1)": 5, 
	"(0, -1)": 6, 
	"(1, -1)": 7, 
}
var exploding = false

var health = 6


func get_input(): 
	direction_x = Input.get_axis("left", "right")
	if Input.is_action_just_pressed("jump"): 
		velocity.y -= jump_strength
	if Input.is_action_just_pressed("shoot") and $ReloadTimer.time_left == 0:
		shoot.emit(position, get_local_mouse_position().normalized())
		$ReloadTimer.start() 
		var tween = get_tree().create_tween()
		$AudioStreamPlayer2D.play()
		tween.tween_property($targetMarker, "scale", Vector2(0.1, 0.1), 0.2)
		tween.tween_property($targetMarker, "scale", Vector2(0.5, 0.5), 0.4)
		

func _physics_process(delta):
		get_input()
		velocity.x = direction_x * speed
		apply_gravity(delta)
		animation()
		move_and_slide()
		update_marker()

func take_damage(value): 
	health -= value
	print("took ", str(value), " damage")
	print(str(health), " health remaining")
	

func apply_gravity(delta): 
	velocity.y += gravity * delta
	
func animation(): 
	$AnimationPlayer.current_animation = 'run' if direction_x else 'idle'
	if direction_x < 0: 
		$legs.flip_h = true	
	else: 
		$legs.flip_h = false
	if not is_on_floor(): 
		$AnimationPlayer.current_animation = "jump"
	var raw_dir = get_local_mouse_position().normalized()
	var adjusted_dir = Vector2i(round(raw_dir.x), round(raw_dir.y))
	$torso.frame = aim_directions[str(adjusted_dir)]

func update_marker(): 
	$targetMarker.position = get_local_mouse_position().normalized() * 60
