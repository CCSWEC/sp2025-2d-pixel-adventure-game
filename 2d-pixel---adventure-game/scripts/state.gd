extends Node
class_name State

signal Transitioned

@export var next_state : String

func enter():
	pass

func exit():
	pass

func update(delta:float):
	pass

func physics_update(delta:float):
	pass
