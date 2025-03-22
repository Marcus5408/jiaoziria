class_name CustomerData
extends Resource

enum CustomerStatus {
    APPROACHING,
    ORDERING,
    WAITING,
    LEAVING
}

@export var id: int = 0
@export var characterResource: Character = Character.new()
@export var status: CustomerStatus = CustomerStatus.APPROACHING 
@export var isAngry: bool = false
@export var order: OrderData
