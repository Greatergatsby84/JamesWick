extends Node2D

@onready var level
@onready var doorColl = $StaticBody2D/DoorCollider
@onready var openAnim = $Open
@onready var closeAnim = $Close
@onready var victoryMusic = preload("res://audio/Victory.mp3")

var enemiesRemain = true
var spawnersEmpty = false
var hasOpened = false
var spawners
# Called when the node enters the scene tree for the first time.
func _ready():
	level = get_tree().get_first_node_in_group("level")
	spawners = get_tree().get_nodes_in_group("spawner")

func _process(_delta):
	enemiesRemain = !get_tree().get_nodes_in_group("enemy").is_empty()
	
	var spawnsRemaining = 0
	for i in spawners:
		spawnsRemaining += i.getRemainingEnemies()
	spawnersEmpty = spawnsRemaining == 0
	if hasOpened:
		return
		
	if !enemiesRemain && spawnersEmpty:
		hasOpened = true
		openElevator()



func _on_area_2d_body_entered(body):
	if body is Player:
		level.win()
		AudioManager.stop_music()
		var asp = AudioStreamPlayer.new()
		asp.stream = victoryMusic
		asp.name = "Victory"
		add_child(asp)
		asp.play()
		closeAnim.visible = true
		closeAnim.play("close")
		await asp.finished
		level.go_to_next_level()

func openElevator():
	openAnim.play("open")
	AudioManager.play_sfx("ding")
	doorColl.disabled = true
