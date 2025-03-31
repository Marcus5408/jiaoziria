class_name customerDetails
extends Resource

enum CustomerStatus {
    APPROACHING,
    ORDERING,
    WAITING,
    LEAVING
}

@export var characterResource: CharacterData = CharacterData.new()
@export var status: CustomerStatus = CustomerStatus.APPROACHING 
@export var isAngry: bool = false
@export var order: OrderData
