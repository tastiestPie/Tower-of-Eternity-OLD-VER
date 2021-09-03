extends KinematicBody2D

#changable variables
export var acceleration = 500
export var max_speed = 150
export var friction = 300
export var jump_height = 400
export var gravity = 20

#static variables
var velocity = Vector2.ZERO
#Note for later - attach stats script here later

#gets other components as variables
onready var animationTree = $AnimationTree
onready var animationPlayer = $AnimationPlayer
#Note for later - don't forget to attack hitbox/hurtbox scripts here

# Called when the node enters the scene tree for the first time.
func _ready():
	animationTree.active = true

#movement fuction: moves player left or right
func move(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y -= gravity
	
	if Input.is_action_just_pressed("jump"):
		input_vector.y = jump_height


func attack(delta):
	velocity = Vector2.ZERO
