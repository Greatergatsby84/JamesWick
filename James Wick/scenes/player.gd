extends CharacterBody2D
class_name Player

@onready var level = get_tree().get_first_node_in_group("level")
@onready var sprite = $AnimatedSprite2D
@onready var bullet_prefab = preload("res://scenes/bullet.tscn")
@onready var iframeTimer = $"I-FrameTimer"
@onready var healthIndicator = $HealthIndicator
@onready var animator = $AnimatedSprite2D
var iframe = false
var isDead = false
@export var SPEED = 5
@export var health = 3
var knockback = Vector2.ZERO
@export var knockback_strength = 10.0


func _physics_process(_delta):
	if level.isOver() || isDead:
		return
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left","right","up","down")

	velocity = direction.normalized() * SPEED
	velocity += knockback
	handleAnimation(direction)
	#	velocity = Vector2.ZERO
	move_and_slide()
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	if Input.is_action_just_pressed("fire"):
		fire()

func _process(_delta):
	if health < 1:
		die()


func fire():
	if isDead:
		return
	var bullet = bullet_prefab.instantiate()
	bullet.position = get_global_position()
	bullet.position.y -= 24
	bullet.set_direction((get_global_mouse_position() - position - Vector2(0,-24.0)).normalized())
	get_tree().get_root().call_deferred("add_child", bullet)
	AudioManager.play_sfx("fireShoot")


func _on_area_2d_body_entered(body):
	if body is Enemy && !iframe:
		var direction = body.global_position.direction_to(global_position)
		knockback = direction * knockback_strength
		print(knockback)
		take_damage()

		
func take_damage():
	set_collision_mask_value(1, false)
	sprite.modulate = Color(1,1,1,.5)
	health -= 1
	healthIndicator.updateHealth(health)
	iframe = true
	iframeTimer.start()
	if health > 0:
		AudioManager.play_sfx("hit")

func handleAnimation(direction):
	if direction == Vector2.ZERO:
		animator.play("default")
	else:
		animator.play("walk")	
	if direction.x < 0:
		animator.flip_h = true
	if direction.x > 0:
		animator.flip_h = false

func _on_i_frame_timer_timeout():
	set_collision_mask_value(1, true)
	sprite.modulate = Color(1,1,1,1)
	iframe = false

func die():
	if isDead:
		return
		
	animator.play("death")
	AudioManager.play_sfx("deathchime")
	isDead = true
	await get_tree().create_timer(1.2).timeout
	level.die()
