extends Node

class_name UpgradeManager

var _upgrades := [
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "left-mg",
        "Add a second machine gun to your loadout",
        80,
        "Hub/LightSlots/Left"
    ).set_new_weapon_vars(
        preload("res://weapons/LeftMachineGun.tscn")
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "mg-rof",
        "Increase the fire rate of your machine gun",
        30,
        "Hub/LightSlots/Center"
    ).set_fire_rate_up_vars(
        0.1
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "right-mg",
        "Add a third machine gun to your loadout",
        80,
        "Hub/LightSlots/Right"
    ).set_new_weapon_vars(
        preload("res://weapons/RightMachineGun.tscn")
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "left-mg-rof",
        "Increase the fire rate of your left machine gun",
        50,
        "Hub/LightSlots/Left"
    ).set_fire_rate_up_vars(
        0.1
    ).add_requirement(
        "left-mg"
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "right-mg-rof",
        "Increase the fire rate of your right machine gun",
        50,
        "Hub/LightSlots/Right"
    ).set_fire_rate_up_vars(
        0.1
    ).add_requirement(
        "right-mg"
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "left-cannon",
        "Add a high damage cannon to your loadout",
        100,
        "Hub/MediumSlots/Left"
    ).set_new_weapon_vars(
        preload("res://weapons/Cannon.tscn")
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "right-cannon",
        "Add a second cannon to your loadout",
        100,
        "Hub/MediumSlots/Right"
    ).set_new_weapon_vars(
        preload("res://weapons/Cannon.tscn")
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "left-cannon-rof",
        "Increase the fire rate of your left cannon",
        150,
        "Hub/MediumSlots/Left"
    ).set_fire_rate_up_vars(
        0.5
    ).add_requirement(
        "left-cannon"
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "right-cannon-rof",
        "Increase the fire rate of your right cannon",
        150,
        "Hub/MediumSlots/Right"
    ).set_fire_rate_up_vars(
        0.5
    ).add_requirement(
        "right-cannon"
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "bladelauncher",
        "Add a sawblade launcher to your loadout",
        200,
        "Hub/HeavySlots/Center"
    ).set_new_weapon_vars(
        preload("res://weapons/BladeLauncher.tscn")
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "bladelauncher-rof",
        "Increase the fire rate of your sawblade launcher",
        250,
        "Hub/HeavySlots/Center"
    ).set_fire_rate_up_vars(
        0.8
    ).add_requirement(
        "bladelauncher"
    ),
]

func get_next_upgrades(count: int) -> Array:
    return _upgrades.slice(0, count - 1)

func burn_upgrade(upgrade: Upgrade):
    _upgrades.erase(upgrade)
