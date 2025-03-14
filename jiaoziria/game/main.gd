extends Control

var globalCustomerCount: int = 0
var customerNames = []
var customerDatas = {}
var possibleCustomers = [
    {"id": 0, "name": "Alice", "picky": 0},
    {"id": 1, "name": "Bob", "picky": 0},
    {"id": 2, "name": "Charles", "picky": 0},
    {"id": 3, "name": "Diana", "picky": 0},
    {"id": 4, "name": "Eve", "picky": 0},
    {"id": 5, "name": "Frank", "picky": 0},
    {"id": 6, "name": "Grace", "picky": 0},
    {"id": 7, "name": "Heidi", "picky": 0},
    {"id": 8, "name": "Ivan", "picky": 0},
    {"id": 9, "name": "Judy", "picky": 0},
]

signal create_new_customer

func add_customer(data: customerData): 
    return
