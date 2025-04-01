extends Control

var globalTicketID: int = 0
var globalCustomerCount: int = 0
var globalcustomerDetails = {}

signal animate_dip_to_black
signal animate_dip_from_black

func transition_dip_to_black():
    emit_signal("animate_dip_to_black")

func transition_dip_from_black():
    emit_signal("animate_dip_from_black")