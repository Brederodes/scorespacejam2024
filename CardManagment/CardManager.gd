class_name CardManager extends Node2D


enum ABILITY_TYPES {JUMP, DASH, GRAPPLE, GRAVITY, WATER};
#4 = Common, 2 = Uncommon, 1 = Rare
var Probability:Dictionary = {ABILITY_TYPES.JUMP : 4,
							  ABILITY_TYPES.DASH : 4,
							  ABILITY_TYPES.GRAPPLE : 2,
							  ABILITY_TYPES.GRAVITY : 1,
							  ABILITY_TYPES.WATER : 1}
							#Total = 12 pls update if changing rarites
var TotalWeight:int = 12;
var Cooldown:float = 0; #start testing at 0

var HandState:Dictionary = {0: false,
							1: false,
							2: false}# true if there is a card in that slot false otherwise

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Random_Ability() -> int:
	randomize()
	var random_value: int = randi_range(0, TotalWeight - 1);
	var cumulative_weight: int = 0;

	for ability in Probability.keys():
		cumulative_weight += Probability[ability]
		if random_value < cumulative_weight:
			return ability
	
	print("Ajeita o TotalWeight nerd");
	return -1
	
func Create_Random_Card()-> Card:
	var newCard_Ability:int = Random_Ability();
	match newCard_Ability:
		ABILITY_TYPES.JUMP:
			return JumpCard.new();
		ABILITY_TYPES.DASH:
			return DashCard.new();
		ABILITY_TYPES.GRAPPLE:
			return GrappleCard.new();
		ABILITY_TYPES.GRAVITY:
			return GravityCard.new();
		ABILITY_TYPES.WATER:
			return WaterCard.new();
	return
	
func Draw_new_card(slot: int) -> void:
	var newCard:Card = Create_Random_Card();
	newCard.Slot = slot;
	newCard.isReady = false;
	$Timer.connect("timeout",newCard.makeReady);
	$Timer.start(Cooldown);
	HandState[slot] = true;
	pass

func Delete_card(card: Card) -> void:
	HandState[card.Slot] = false;
	pass

func Change_card(card: Card) -> void:
	Delete_card(card);
	Draw_new_card(card.slot);
	pass

func _on_card_card_used(card: Card) -> void:
	Change_card(card);
	pass
