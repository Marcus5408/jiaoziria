extends Control

var globalTicketID: int = 0
var globalCustomerCount: int = 0
var globalCustomerDetails = {}

enum TransitionStates {
	IDLE,
	DIP,
	BLACK,
	RISE
}
var transitionState: TransitionStates
const transitionTimer: float = 0.1
