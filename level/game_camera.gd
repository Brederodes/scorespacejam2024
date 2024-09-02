class_name GameCamera extends Camera2D

@export var player : Player;
@export var lerp_weight : float;

func _process(delta):
	position = lerp(position, player.position, clamp(lerp_weight , 0, 1));
func _ready():
	enabled = true;
	pass
