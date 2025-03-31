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
@export var sauce2: Dictionary = {
    "base": SauceBase.NONE,
    "addition1": SauceAddition.NONE,
    "addition2": SauceAddition.NONE,
    "addition3": SauceAddition.NONE,
}
@export var sauce3: Dictionary = {
    "base": SauceBase.NONE,
    "addition1": SauceAddition.NONE,
    "addition2": SauceAddition.NONE,
    "addition3": SauceAddition.NONE,
}

static func create() -> OrderData:
    var available_fillings = FillingType.values()
    var available_cooking = CookingMethod.values()
    var available_bases = SauceBase.values()
    var available_additions = SauceAddition.values()

    var new_ticket_info = OrderData.new()
    new_ticket_info.ticketID = 0
    new_ticket_info.ownerID = 0
    new_ticket_info.fillings = [
        available_fillings[randi() % (available_fillings.size() - 1)],
        available_fillings[randi() % available_fillings.size()],
    ]
    new_ticket_info.cookingTime = randi() % 8 # random cooking time between 1 and 10
    new_ticket_info.cookingMethod = available_cooking[randi() % (available_cooking.size() - 1)]
    
    new_ticket_info.sauce1 = {
        "base": available_bases[randi() % (available_bases.size() -1 )],
        "addition1": available_additions[randi() % available_additions.size()],
        "addition2": available_additions[randi() % available_additions.size()],
        "addition3": available_additions[randi() % available_additions.size()],
    }
    new_ticket_info.sauce2 = {
        "base": available_bases[randi() % (available_bases.size())],
        "addition1": available_additions[randi() % available_additions.size()],
        "addition2": available_additions[randi() % available_additions.size()],
        "addition3": available_additions[randi() % available_additions.size()],
    }
    new_ticket_info.sauce3 = {
        "base": available_bases[randi() % (available_bases.size())],
        "addition1": available_additions[randi() % available_additions.size()],
        "addition2": available_additions[randi() % available_additions.size()],
        "addition3": available_additions[randi() % available_additions.size()],
    }
    return new_ticket_info
