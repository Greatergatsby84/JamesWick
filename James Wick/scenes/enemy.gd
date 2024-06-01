extends CharacterBody2D
class_name Enemy

@onready var player = get_tree().get_first_node_in_group("player")
@export var SPEED = 1000
@onready var enemy = $"."
@onready var animator = $AnimatedSprite2D
@onready var lightocc = $LightOccluder2D
@onready var coll = $CollisionShape2D
@onready var hitbox = $hitbox/CollisionShape2D
var isDead = false
var deathAvoidance = Vector2.ZERO
func _physics_process(delta):

	if player == null || isDead:
		return
	
	if player.isDead :
		deathAvoidance = Vector2(200.0, 200.0)
	
	$NavigationAgent2D.set_target_position(player.global_position + deathAvoidance)
	if not $NavigationAgent2D.is_navigation_finished():
		var movement_delta = SPEED * delta
		var current_agent_position = global_position
		var next_path_position = $NavigationAgent2D.get_next_path_position()
		velocity = (next_path_position - current_agent_position).normalized() * movement_delta
		if velocity.x < 0:
			animator.flip_h = true
		if velocity.x > 0:
			animator.flip_h = false
		move_and_slide()

func set_health():
	pass
	
func set_speed(value):
	SPEED = value

func _on_area_2d_body_entered(body):
	if body is Projectile && !isDead:
		isDead = true
		AudioManager.play_sfx("oof")
		animator.play("death")
		body.queue_free()
		hitbox.queue_free()
		coll.queue_free()
		lightocc.queue_free()
		await get_tree().create_timer(1.0).timeout		
		enemy.queue_free()
