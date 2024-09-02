class_name CarpetCard extends Card

@export var carpet_time:float;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func do_ability() -> void:
	print("tapetei");
	player.carpet_time_left = carpet_time;
	super();
	pass;
