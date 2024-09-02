class_name PortalCard extends Card

@export var dash_distance : float;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func do_ability() -> void:
	print("portei");
	var test_transform : Transform2D = Transform2D(player.transform);
	test_transform.origin.x += dash_distance;
	
	if(player.test_move(test_transform, Vector2(0,0))):
		print("MORREU");
		return;
	player.position.x += dash_distance; 
	super();
	pass;
