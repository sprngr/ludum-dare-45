extends Node

var current_scene = null

func _ready():
    # Get current scene at root, store into memory for use later
    current_scene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)

func set_scene(scene : PackedScene): 
    current_scene.queue_free()
    current_scene = scene.instance()
    get_tree().get_root().call_deferred("add_child", current_scene)