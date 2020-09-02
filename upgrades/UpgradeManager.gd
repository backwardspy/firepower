extends Node

class_name UpgradeManager

var _upgrades := [
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "Add a second machine gun to your loadout",
        80,
        "Hub/LightSlots/Left"
    ).set_new_weapon_vars(
        preload("res://weapons/LeftMachineGun.tscn")
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "Increase the fire rate of your machine gun",
        30,
        "Hub/LightSlots/Center"
    ).set_fire_rate_up_vars(
        0.1
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "Add a third machine gun to your loadout",
        80,
        "Hub/LightSlots/Right"
    ).set_new_weapon_vars(
        preload("res://weapons/RightMachineGun.tscn")
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "Increase the fire rate of your left machine gun",
        50,
        "Hub/LightSlots/Left"
    ).set_fire_rate_up_vars(
        0.1
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "Increase the fire rate of your right machine gun",
        50,
        "Hub/LightSlots/Right"
    ).set_fire_rate_up_vars(
        0.1
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "Add a high damage cannon to your loadout",
        100,
        "Hub/MediumSlots/Left"
    ).set_new_weapon_vars(
        preload("res://weapons/Cannon.tscn")
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "Add a second cannon to your loadout",
        100,
        "Hub/MediumSlots/Right"
    ).set_new_weapon_vars(
        preload("res://weapons/Cannon.tscn")
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "Increase the fire rate of your left cannon",
        150,
        "Hub/MediumSlots/Left"
    ).set_fire_rate_up_vars(
        0.5
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "Increase the fire rate of your right cannon",
        150,
        "Hub/MediumSlots/Right"
    ).set_fire_rate_up_vars(
        0.5
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "Add a sawblade launcher to your loadout",
        200,
        "Hub/HeavySlots/Center"
    ).set_new_weapon_vars(
        preload("res://weapons/BladeLauncher.tscn")
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "Increase the fire rate of your sawblade launcher",
        250,
        "Hub/HeavySlots/Center"
    ).set_fire_rate_up_vars(
        0.8
    ),
]

func get_next_upgrades(count: int) -> Array:
    return _upgrades.slice(0, count - 1)

func burn_upgrade(upgrade: Upgrade):
    _upgrades.erase(upgrade)
