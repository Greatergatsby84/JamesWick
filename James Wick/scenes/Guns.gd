extends Node2D

@onready var bullet_prefab = preload("res://scenes/bullet.tscn")
@export var SPEED = 25
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("fire"):
		fire()

	
	
func fire():
	var bullet = bullet_prefab.instantiate()
	bullet.position = get_global_position()
	bullet.position.y -= 16
	bullet.set_direction(Vector2(SPEED,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet)
