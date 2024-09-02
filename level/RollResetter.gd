class_name RollResetter extends Area2D

@export var level_grid : LevelGrid;
var rollable_objects : Array = Array();
var world_scale : float;

func roll_by_amount(roll_amount : int):
	print("ROLANDO NÍVEL");
	var rows = level_grid.level_rows;
	for row in rows:
		row.roll_row_by(roll_amount);
	for rollable in rollable_objects:
		rollable.position.x -= world_scale * roll_amount * (rows[0].platform_size + rows[0].separation_between_tiles);

func _ready():
	rollable_objects.append($"../Player");
	rollable_objects.append($"../Camera2D");
	connect("body_entered", _on_body_entered);
	world_scale = $"../LevelGrid".scale.x;
	pass

func _on_body_entered(body : Node2D):
	roll_by_amount(5);
