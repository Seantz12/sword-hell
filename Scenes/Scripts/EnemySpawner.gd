extends Node2D

signal spawn_enemy(enemy)
signal no_more_enemies
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var number_enemies_to_spawn = 0
export var spawn_time = 0.5

var default_enemy = preload("res://Scenes/DefaultEnemy.tscn")
var archer_enemy = preload("res://Scenes/ArcherEnemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    $Timer.wait_time = spawn_time
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _on_Timer_timeout():
    #if number_enemies_to_spawn > 0:
    if true: # temporarily have infinite enemies
        var enemy
        if randf() < 0.6:
            enemy = default_enemy.instance()
        else:
            enemy = archer_enemy.instance()
        position = Vector2()
        position.x = rand_range(50.0, 400.0)
        position.y = rand_range(10.0, 30.0)
        enemy.position = position
        emit_signal("spawn_enemy", enemy)
        number_enemies_to_spawn -= 1
    else:
        emit_signal("no_more_enemies")
