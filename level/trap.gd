class_name Trap extends Area2D
@export var player : Player;

func _ready():
	player = $"../../Player";
	connect("body_entered", kill_player);
func kill_player(body : Node2D):
	player.kill();
