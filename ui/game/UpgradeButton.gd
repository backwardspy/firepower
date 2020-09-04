extends Button

class_name UpgradeButton

var _upgrade: Upgrade
var _reqs_met: bool

func _enable():
    disabled = false
    $CostBox/Price.modulate = Color.white

func _disable():
    disabled = true
    $CostBox/Price.modulate = Color.red

func _update_mode():
    $CostBox/ScrapIcon.visible = _reqs_met

    $CostBox.alignment = BoxContainer.ALIGN_END if _reqs_met else BoxContainer.ALIGN_CENTER

    var price_text: String
    if _reqs_met:
        price_text = str(_upgrade.price)
    else:
        price_text = "weapon not mounted"
    $CostBox/Price.text = price_text

func apply_upgrade(upgrade: Upgrade, wallet_balance: int, reqs_met: bool):
    _upgrade = upgrade
    _reqs_met = reqs_met
    $Box/Title.text = upgrade.title
    $Box/Description.text = upgrade.description

    if not reqs_met:
        _disable()
    else:
        check_scrap_adequacy(wallet_balance)

    _update_mode()

func check_scrap_adequacy(wallet_balance: int):
    if not _reqs_met:
        return  # we can't buy this upgrade no matter the wallet balance
    if wallet_balance >= _upgrade.price:
        _enable()
    else:
        _disable()
