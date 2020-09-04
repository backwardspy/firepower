extends KinematicBody2D

class_name Player

signal health_changed
signal weapon_added
signal died

export var move_speed := 100.0
export var max_health := 500.0

var _vel := Vector2.ZERO
var _dead := false

# we keep track of how many weapons we've added in order to
# reduce volume on new weapons by the correct amount
var _weapons_added := 0

onready var _health := max_health
onready var _wallet: Wallet = get_node("/root/Wallet")
onready var _score_tracker: ScoreTracker = get_node("/root/ScoreTracker")

func hurt(damage: float):
    if _dead:
        return

    _health -= damage
    if _health <= 0.0:
        _die()

    emit_signal("health_changed", _health / max_health)

func heal(healing: float):
    if _dead:
        return

    _health = min(_health + healing, max_health)
    emit_signal("health_changed", _health / max_health)

func _die():
    _health = 0.0
    _dead = true
    emit_signal("died")
    modulate = Color(8, 7, 6, 1)
    $Boombox.play()
    $AnimationPlayer.play("explosion")
    $CollisionShape2D.queue_free()
    $LootSuccArea.queue_free()
    $Shadow.queue_free()
    $Hub/HeavySlots.queue_free()
    $Hub/MediumSlots.queue_free()
    $Hub/LightSlots.queue_free()
    set_process(false)

func _apply_new_weapon_upgrade(upgrade: Upgrade):
    var slot := get_node(upgrade.weapon_path)
    if slot.get_child_count():
        push_error(
            "An upgrade asked for %s to be added to slot %s but that slot already contains a child!" % [
                upgrade.weapon_scene,
                upgrade.weapon_slot
            ]
        )
        return

    var weapon := upgrade.weapon_scene.instance()

    var err := connect("weapon_added", weapon, "reduce_volume")
    if err:
        # we don't return here because it's hardly a fatal problem
        push_error("failed to connect weapon_added signal to weapon: %s" % err)
    slot.add_child(weapon)

    if weapon.reduces_volume_on_add:
        if _weapons_added > 0:
            # reduce volume on this weapon once per existing added weapon
            weapon.reduce_volume(_weapons_added)
        _weapons_added += 1

        # reduce volume on all weapons once more
        emit_signal("weapon_added")

func _apply_fire_rate_upgrade(upgrade: Upgrade):
    var slot := get_node(upgrade.weapon_path)
    if slot.get_child_count() != 1:
        push_error(
            "An upgrade asked for slot %s to have its fire rate changed but that slot has the wrong number of children" % [
                upgrade.weapon_path
            ]
        )
        return
    var weapon: Weapon = slot.get_child(0)
    weapon.time_between_shots = upgrade.time_between_shots

func _apply_upgrade(upgrade: Upgrade):
    match upgrade.type:
        Upgrade.NEW_WEAPON: _apply_new_weapon_upgrade(upgrade)
        Upgrade.FIRE_RATE_UP: _apply_fire_rate_upgrade(upgrade)

func _damp(a: Vector2, b: Vector2, lambda: float, dt: float) -> Vector2:
    return lerp(a, b, 1 - exp(-lambda * dt))

func _move(dt: float):
    var move := Vector2(
        int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left")),
        int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
    ).normalized() * move_speed

    _vel = _damp(_vel, move, 10.0, dt)
    _vel = move_and_slide(_vel)

    var to_mouse := get_global_mouse_position() - global_position
    $Hub.rotation = atan2(to_mouse.y, to_mouse.x)
    $Shadow.rotation = $Hub.rotation

func _process(dt: float):
    if _dead:
        return
    _move(dt)

func _on_LootSuccArea_body_entered(body):
    if body is Scrap:
        body.succ(self)
        _wallet.add_scrap(1)
        _score_tracker.add_scrap_earned(1)

func _on_UpgradeShop_upgrade_purchased(upgrade: Upgrade, _final: bool):
    _apply_upgrade(upgrade)
    heal(max_health * 0.5)
