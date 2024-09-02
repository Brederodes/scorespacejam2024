class_name DashCard extends Card
@export var dash_speed : float;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func do_ability() -> void:
	print("dashei");
	var player_floor_snap_length_temp = player.floor_snap_length;
	if(player.get_floor_normal().x > 0):
		player.floor_snap_length = 0;
	if(player.velocity.x < 0 ):
		player.velocity.x = dash_speed;
	else:
		player.velocity.x += dash_speed;
	player.velocity.y = 0;
	player.move_and_slide();
	if(player.get_floor_normal().x > 0):
		player.floor_snap_length = player_floor_snap_length_temp;
	super();
	pass;
