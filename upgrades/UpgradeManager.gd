extends Node

class_name UpgradeManager

var _upgrades := [
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "mg-rof",
        "Increase the fire rate of your machine gun",
        50,
        "Hub/LightSlots/Center"
    ).set_fire_rate_up_vars(
        0.1
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "left-mg",
        "Add a left-mounted machine gun to your loadout",
        80,
        "Hub/LightSlots/Left"
    ).set_new_weapon_vars(
        preload("res://weapons/LeftMachineGun.tscn")
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "right-mg",
        "Add a right-mounted machine gun to your loadout",
        120,
        "Hub/LightSlots/Right"
    ).set_new_weapon_vars(
        preload("res://weapons/RightMachineGun.tscn")
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "left-mg-rof",
        "Increase the fire rate of your left machine gun",
        100,
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
        140,
        "Hub/LightSlots/Right"
    ).set_fire_rate_up_vars(
        0.1
    ).add_requirement(
        "right-mg"
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "left-cannon",
        "Add a left-mounted cannon to your loadout",
        200,
        "Hub/MediumSlots/Left"
    ).set_new_weapon_vars(
        preload("res://weapons/Cannon.tscn")
    ),
    Upgrade.new().init(
        Upgrade.NEW_WEAPON,
        "right-cannon",
        "Add a right-mounted cannon to your loadout",
        200,
        "Hub/MediumSlots/Right"
    ).set_new_weapon_vars(
        preload("res://weapons/Cannon.tscn")
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "left-cannon-rof",
        "Increase the fire rate of your left cannon",
        250,
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
        250,
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
        300,
        "Hub/HeavySlots/Center"
    ).set_new_weapon_vars(
        preload("res://weapons/BladeLauncher.tscn")
    ),
    Upgrade.new().init(
        Upgrade.FIRE_RATE_UP,
        "bladelauncher-rof",
        "Increase the fire rate of your sawblade launcher",
        350,
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

func any_upgrades_left() -> bool:
    return _upgrades.size() > 0
