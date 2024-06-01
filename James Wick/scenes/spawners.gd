extends Node2D

@onready var enemy = preload("res://scenes/shortenemy.tscn")
@onready var bigEnemy = preload("res://scenes/enemy.tscn")
@onready var enemy_pool = $enemy_pool
var level
var isActive = false
var isEmpty = false
@export var spawn_per_wave = 5
@export var number_of_waves = 5
@export var number_of_bosses = 3
@export var boss_speed = 27500
@export var lackie_speed = 30000

var is_spawning = false
# Called when the node enters the scene tree for the first time.
func _ready():
	level = get_tree().get_first_node_in_group("level")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if is_spawning:
		return

	if !isActive:
		return

	if isEmpty:
		return


	if enemy_pool.get_child_count() < 1:
		if number_of_waves == 0:
			if number_of_bosses > 0:
				spawn_boss()
			else:
				isEmpty = true
		else:
			spawn_wave()
	


func spawn_wave():
	is_spawning = true
	number_of_waves -= 1
	for i in spawn_per_wave:

		var new_enemy_instance = enemy.instantiate()
		new_enemy_instance.set_speed(lackie_speed)
		await get_tree().create_timer(0.5).timeout
		enemy_pool.add_child(new_enemy_instance)
	is_spawning = false

func spawn_boss():
	is_spawning = true
	for i in number_of_bosses:
		var new_enemy_instance = bigEnemy.instantiate()
		new_enemy_instance.set_speed(boss_speed)
		await get_tree().create_timer(0.5).timeout
		enemy_pool.add_child(new_enemy_instance)
	number_of_bosses = 0
	is_spawning = false

func _on_area_2d_body_entered(body):
	if body is Player:
		isActive = true

func getRemainingEnemies():
	return spawn_per_wave * number_of_waves + number_of_bosses
