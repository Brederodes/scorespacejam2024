class_name LevelRow extends Node2D
var level_platform_scenes : Array = Array();
var current_level_platforms : Array = Array();
@export var platform_size : float;
@export var separation_between_tiles : float;
@export var row_platforms_count : int;
var rng = RandomNumberGenerator.new();
func load_platform_scenes_variable():
	for n in 8:
		level_platform_scenes.append(load("res://platforms/platform"+str(n)+".tscn"));
func randomize_all_blocks():
	for platform in current_level_platforms:
		platform.queue_free();

	for n in row_platforms_count:
		var new_platform = level_platform_scenes[rng.randi_range(0,7)].instantiate();
		current_level_platforms.append(new_platform);
		add_child(new_platform);
		new_platform.position.x = n * (platform_size + separation_between_tiles);
		continue
func roll_row_by(roll_amount : int):
	if( roll_amount < 1):
		return;

	if(roll_amount > current_level_platforms.size()):
		roll_amount = current_level_platforms.size();

	for n in roll_amount:
		current_level_platforms[n].free();

	current_level_platforms = current_level_platforms.slice(roll_amount);
	for n in current_level_platforms.size():
		current_level_platforms[n].position.x = n * (platform_size + separation_between_tiles);

	for n in roll_amount:
		var new_platform = level_platform_scenes[rng.randi_range(0,7)].instantiate();
		current_level_platforms.append(new_platform);
		call_deferred("add_child", new_platform);
		new_platform.position.x = (n + row_platforms_count - roll_amount) * (platform_size + separation_between_tiles);

	print(current_level_platforms.size());

func _ready():
	load_platform_scenes_variable();
	randomize_all_blocks();
