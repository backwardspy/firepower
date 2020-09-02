extends Label

func _on_scrap_changed(amount: int):
    text = "x %s" % amount

func _ready():
    var err := get_node("/root/Wallet").connect("scrap_changed", self, "_on_scrap_changed")
    if err:
        push_error("failed to connect wallet scrap_changed signal: %s" % err)
