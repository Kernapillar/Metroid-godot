extends Node2D

var bullet_scene = preload("res://scenes/Projectiles/bullet.tscn")

func _on_player_shoot(pos, dir):
	var bullet = bullet_scene.instantiate() as Area2D
	$Projectiles.add_child(bullet)
	bullet.setup(pos, dir)
