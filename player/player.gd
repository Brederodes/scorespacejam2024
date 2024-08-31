class_name Player extends CharacterBody2D
@export_category("Constants")
@export var initialPlayerMaxRunningSpeed : float = 5;
@export var playerMaxFallingSpeed : float = 10;
@export var playerDeceleration : float = 5;
@export var initialPlayerAcceleration : float = 1;
@export var playerGravityAcceleration: float = 4;

@export_category("Iteration Values")
@export var playerMaxRunningSpeed : float = 5;
@export var playerAcceleration : float = 1;
@export var current_state : PLAYER_STATES = PLAYER_STATES.FALLING;
enum PLAYER_STATES
{
	RUNNING,
	FALLING,
	CASTING_ABILITY,
}
func changed_state() -> bool:
	return false;

func apply_running_acceleration(delta : float) -> void:
	var realVelocity = get_real_velocity();
	#if(get_floor_normal().x > cos(0.7)):
	#	velocity = realVelocity;
	if(velocity.x > playerMaxRunningSpeed):
		velocity.x -= playerDeceleration * delta;
	if(velocity.x < playerMaxRunningSpeed):
		velocity.x += playerAcceleration * delta;
	pass
func apply_falling_acceleration(delta : float) -> void:
	var realVelocity = get_real_velocity();
	if(realVelocity.y > playerMaxFallingSpeed):
		velocity.y -= playerDeceleration * delta;
		return;
	else:
		velocity.y += playerGravityAcceleration * delta;
	pass
func act_according_to_ability():
	pass
func _physics_process(delta):
	var number_of_changes : int = 0;
	match current_state:
		PLAYER_STATES.RUNNING:
			apply_running_acceleration(delta);
		PLAYER_STATES.FALLING:
			apply_falling_acceleration(delta);
		PLAYER_STATES.CASTING_ABILITY:
			act_according_to_ability();
	move_and_slide();
	pass
func _ready():
	$FloorDetector.connect("turned_airborne", react_to_airborn);
	$FloorDetector.connect("turned_grounded", react_to_grounded);
	playerAcceleration = initialPlayerAcceleration;
	playerMaxRunningSpeed = initialPlayerMaxRunningSpeed;

func react_to_grounded():
	current_state = PLAYER_STATES.RUNNING;
	pass;
func react_to_airborn():
	if(current_state == PLAYER_STATES.CASTING_ABILITY):
		return
	current_state = PLAYER_STATES.FALLING;
	pass
func react_to_ended_ability():
	pass
