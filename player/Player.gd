extends KinematicBody2D

class_name Player

signal health_changed
signal died

export var move_speed := 100.0
export var max_health := 500.0

var _vel := Vector2.ZERO

onready var _health := max_health
onready var _wallet: Wallet = get_node("/root/Wallet")

func hurt(damage: float):
    _health -= damage
    if _health <= 0.0:
        _health = 0.0
        emit_signal("died")

    emit_signal("health_changed", _health / max_health)

func heal(healing: float):
    _health = min(_health + healing, max_health)
    emit_signal("health_changed", _health / max_health)

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
    slot.add_child(weapon)

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
    _move(dt)

func _on_LootSuccArea_body_entered(body):
    if body is Scrap:
        body.succ(self)
        _wallet.add_scrap(1)

func _on_UpgradeShop_upgrade_purchased(upgrade: Upgrade):
    _apply_upgrade(upgrade)
    heal(max_health * 0.5)
