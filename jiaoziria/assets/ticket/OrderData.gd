class_name OrderData
extends Resource

# fillingType type
enum FillingType {
	PORK,
	CABBAGE,
	SCALLION,
	CHIVE,
	SHRIMP,
	CHICKEN,
	MUSHROOM,
	BEEF,
	TOFU,
	KIMCHI,
	ORPHEUS,
	NONE
}

enum CookingMethod {
	BOIL,
	FRY,
	NONE
}

enum SauceBase {
	SOY_SAUCE,
	VINEGAR,
	GARLIC_OIL,
	SESAME_OIL,
	CHILI_OIL,
	NONE
}

enum SauceAddition {
	GARLIC,
	GINGER,
	SCALLION,
	SESAME_SEED,
	CHILI,
	NONE
}

@export var ticketID: int = 0
@export var ownerID: int = 0
@export var fillings: Array = [
	FillingType.NONE,
	FillingType.NONE
]
@export var cookingTime: int = 0
@export var cookingMethod: CookingMethod = CookingMethod.NONE
@export var sauce1: Dictionary = {
	"base": SauceBase.NONE,
	"addition1": SauceAddition.NONE,
	"addition2": SauceAddition.NONE,
	"addition3": SauceAddition.NONE,
}

static func create() -> OrderData:
	var available_fillings = FillingType.values()
	var available_cooking = CookingMethod.values()

	var new_ticket_info = OrderData.new()
	new_ticket_info.ticketID = 0
	new_ticket_info.ownerID = 0
	new_ticket_info.fillings = [
		available_fillings[randi() % (available_fillings.size() - 1)],
		available_fillings[randi() % available_fillings.size()],
	]
	new_ticket_info.cookingTime = randi() % 8  # random cooking time between 1 and 10
	new_ticket_info.cookingMethod = available_cooking[randi() % (available_cooking.size() - 1)]

	# Generate sauces
	new_ticket_info.sauce1 = generate_sauce(false)  # First sauce can't be NONE

	return new_ticket_info

# Helper function to check if previous additions are NONE
static func set_sauce_additions(base_value, prev_additions: Array) -> Array:
	if base_value == SauceBase.NONE or prev_additions.has(SauceAddition.NONE):
		return [SauceAddition.NONE, SauceAddition.NONE, SauceAddition.NONE]
	return prev_additions

# Helper function to generate a random sauce
static func generate_sauce(allow_none: bool) -> Dictionary:
	var available_bases = SauceBase.values()
	var available_additions = SauceAddition.values()
	var base = available_bases[randi() % (available_bases.size() - (1 if not allow_none else 0))]
	var additions = []
	for _i in range(3):
		additions.append(available_additions[randi() % (available_additions.size() - 1)])
	additions = set_sauce_additions(base, additions)
	return {
		"base": base,
		"addition1": additions[0],
		"addition2": additions[1],
		"addition3": additions[2],
	}
