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
var last_frame_real_velocity : Vector2 = Vector2();
var last_frame_position : Vector2 = Vector2();
enum PLAYER_STATES
{
	RUNNING,
	FALLING,
	CASTING_ABILITY,
}
func update_current_state() -> bool:
	var is_touching_floor : bool = is_on_floor();
	match current_state:
		PLAYER_STATES.RUNNING:
			if(!is_touching_floor):
				current_state = PLAYER_STATES.FALLING;
				#resolving slopes quirkiness
				velocity = last_frame_real_velocity;
				position = last_frame_position;
				move_and_slide()
				return true;
		PLAYER_STATES.FALLING:
			if(is_touching_floor):
				current_state = PLAYER_STATES.RUNNING;
				return true;
	return false;

func apply_running_acceleration(delta : float) -> void:
	if(velocity.x > playerMaxRunningSpeed):
		velocity.x -= playerDeceleration * delta;
	if(velocity.x < playerMaxRunningSpeed):
		velocity.x = clamp(velocity.x + playerAcceleration * delta, velocity.x, playerMaxRunningSpeed);
	print("RUN velocity: ",velocity);
	print("RUN real_spd:", get_real_velocity());
	pass
func apply_falling_acceleration(delta : float) -> void:
	if(velocity.y > playerMaxFallingSpeed):
		velocity.y -= playerDeceleration * delta;
		print("FAL velocity: ",velocity);
		print("FAL real_spd:", get_real_velocity());
		return;
	else:
		velocity.y = clamp(velocity.y + playerGravityAcceleration * delta,
		velocity.y,
		playerMaxFallingSpeed);
		print("FAL velocity: ",velocity);
		print("FAL real_spd:", get_real_velocity());
	pass
func act_according_to_ability():
	pass
func _physics_process(delta):
	match current_state:
		PLAYER_STATES.RUNNING:
			apply_running_acceleration(delta);
		PLAYER_STATES.FALLING:
			apply_falling_acceleration(delta);
		PLAYER_STATES.CASTING_ABILITY:
			act_according_to_ability();
	last_frame_real_velocity = get_real_velocity();
	last_frame_position = position;
	move_and_slide();
	while update_current_state():
		continue
	pass
func _ready():
	playerAcceleration = initialPlayerAcceleration;
	playerMaxRunningSpeed = initialPlayerMaxRunningSpeed;

func react_to_grounded():
	current_state = PLAYER_STATES.RUNNING;
	pass;
func react_to_airborn():
	if(current_state == PLAYER_STATES.CASTING_ABILITY):
		return
	current_state = PLAYER_STATES.FALLING;
	velocity.y = get_real_velocity().y;
	pass
func react_to_ended_ability():
	pass
