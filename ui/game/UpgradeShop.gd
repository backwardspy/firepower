extends Control

signal upgrade_purchased
signal wave_repeated

export(NodePath) var upgrade_manager_path: NodePath
onready var _upgrade_man: UpgradeManager = get_node(upgrade_manager_path)

const upgrade_button_scene = preload("res://ui/game/UpgradeButton.tscn")

# track which upgrades have been bought to allow for requirements validation
var _bought_slugs = []

func _requirements_met(upgrade: Upgrade) -> bool:
    for requirement in upgrade.requirements:
        if not _bought_slugs.has(requirement):
            return false
    return true

func _on_Repeat_pressed():
    emit_signal("wave_repeated")

func _on_upgrade_chosen(upgrade: Upgrade):
    if not Wallet.try_remove_scrap(upgrade.price):
        return  # TODO: some sort of notification/sound effect?

    _bought_slugs.append(upgrade.slug)
    _upgrade_man.burn_upgrade(upgrade)

    var final := not _upgrade_man.any_upgrades_left()

    emit_signal("upgrade_purchased", upgrade, final)

func show():
    for child in $UpgradeButtons.get_children():
        child.queue_free()

    var upgrades := _upgrade_man.get_next_upgrades(2)
    for upgrade in upgrades:
        var reqs_met := _requirements_met(upgrade)

        var b: UpgradeButton = upgrade_button_scene.instance()
        b.apply_upgrade(upgrade, Wallet.get_balance(), reqs_met)

        var err := Wallet.connect("scrap_changed", b, "check_scrap_adequacy")
        if err:
            push_error("failed to connect wallet scrap_changed signal: %s" % err)
            return

        err = b.connect("pressed", self, "_on_upgrade_chosen", [upgrade])
        if err:
            push_error("failed to connect button pressed signal: %s" % err)
            return

        $UpgradeButtons.add_child(b)

    visible = true

func hide():
    visible = false
