extends KinematicBody2D

#changable variables
export var acceleration = 500
export var max_speed = 150
export var friction = 300
export var enemy_range = 4

#for state machine
enum{
	IDLE,
	WANDER,
	CHASE
}

#static variables
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

#bat starts in idle state when initialized, ***change to randomize state when entering later
var state = IDLE

#gets other components as variables
#Note for later - attach stats script here later
onready var animationPlayer = $AnimationPlayer
onready var playerDetectionZone = $playerDetection
onready var sprite = $AnimatedSprite
#Note for later - don't forget to attack hitbox/hurtbox scripts here


# Called when the node enters the scene tree for the first time.
func _ready():
	state = IDLE
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			seek_player()
			
		
		WANDER:
			pass
		
		#if player is in range, bat will start to move towards player
		#**To fix: bat will get stuck in obstacles if there are any in the way,
		#find more elegant solution to pathfinding later
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				acceleration_towards_point(player.global_position, delta)
			else:
				state = IDLE

	velocity = move_and_slide(velocity)


func acceleration_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	sprite.flip_h = velocity.x < 0

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
