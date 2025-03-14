class_name customerData
extends Resource

enum CustomerStatus {
    APPROACHING,
    ORDERING,
    WAITING,
    LEAVING
}

@export var customerID: int = 0
@export var customer: Character = Character.new()
@export var status: CustomerStatus = CustomerStatus.APPROACHING 
@export var isAngry: bool = false
