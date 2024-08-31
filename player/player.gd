class_name Player extends CharacterBody2D
@export var playerMaxHorizontalSpeed : float;

enum PLAYER_STATES 
{
	RUNNING,
	FALLING,
	CASTING_ABILITY,
}

var current_state : PLAYER_STATES = PLAYER_STATES.RUNNING;
