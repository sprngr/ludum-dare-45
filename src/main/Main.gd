extends Node

export (PackedScene) var next_scene

func _ready():
    Game.set_scene(next_scene)