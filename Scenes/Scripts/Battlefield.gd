extends ParallaxBackground


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemies_killed = 0
var player_lives = 3

var attack_powerup = preload("res://Scenes/AttackPowerup.tscn")
var attack_wave = preload("res://Scenes/AttackWave.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    scroll_offset.y += 100 * delta 

####### Event listeners

func _on_EnemySpawner_spawn_enemy(enemy):
    enemy.connect("enemy_died", self, "_on_Enemy_died")
    enemy.connect("bullet_fired", self, "_on_Enemy_fired")
    enemy.player_reference = $Player
    add_child(enemy)

# Enemy events

func _on_Enemy_died(area, position):
    if area != $Player:
        enemies_killed += 1
        $KillCount.text = "Killed: " + str(enemies_killed)
        if randf() < 0.2:
            var new_powerup = attack_powerup.instance()
            new_powerup.connect("on_pickedup", self, "_on_powerup_pickedup")
            new_powerup.position = position
            add_child(new_powerup)

func _on_Enemy_fired(bullet):
    add_child(bullet)

# Player powerup events

func _on_powerup_pickedup(type, duration):
    $Player.add_attack_powerup(type, duration)

func _on_Player_powerup_changed(name, duration):
    $PowerupDuration.text = name + " duration: " + str(round(duration))

# Player events

func _on_Player_wave_fired(position):
    var new_wave = attack_wave.instance()
    new_wave.position = position
    add_child(new_wave)

func _on_Player_died(position):
    player_lives -= 1
    $Lives.text = "Lives :" + str(player_lives)
    if player_lives == 0:
        $Player.queue_free()
        $GameOver.visible = true
    else:
        $Player.position = Vector2(182, 730)
