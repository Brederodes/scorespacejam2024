class_name JumpCard extends Card

@export var jump_speed : float;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func do_ability() -> void:
	print("jumpei");
	var player_floor_snap_temp : float = player.floor_snap_length;
	player.floor_snap_length = 0;
	if(player.velocity.y > 0):
		player.velocity.y = -jump_speed;
	else:
		player.velocity.y -= jump_speed;
	player.move_and_slide();
	player.floor_snap_length = player_floor_snap_temp;
	super();
	pass;
