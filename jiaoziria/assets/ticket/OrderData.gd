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
    FillingType.PORK,
    FillingType.CABBAGE
]
@export var cookingTime: int = 0
@export var cookingMethod: CookingMethod = CookingMethod.NONE
@export var sauce1: Dictionary = {
    "base": SauceBase.SOY_SAUCE,
    "addition1": SauceAddition.NONE,
    "addition2": SauceAddition.NONE,
    "addition3": SauceAddition.NONE,
}
@export var sauce2: Dictionary = {
    "base": SauceBase.SOY_SAUCE,
    "addition1": SauceAddition.NONE,
    "addition2": SauceAddition.NONE,
    "addition3": SauceAddition.NONE,
}
@export var sauce3: Dictionary = {
    "base": SauceBase.SOY_SAUCE,
    "addition1": SauceAddition.NONE,
    "addition2": SauceAddition.NONE,
    "addition3": SauceAddition.NONE,
}
