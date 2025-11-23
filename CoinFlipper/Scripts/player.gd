extends Node2D

var headsProbability := .2;
var coinValue := 0.01;
var comboMulti := 2;
var coinFlipTime := 3.0;
var playerBank := 0.00;
var streak := 0;

var upgradePrices := [0.01, 0.1, 1.0, 5.0, 10.0]
@export var bank_label: Label
@export var result_label: Label

func _on_flip_coin_pressed() -> void:
	if randf() < headsProbability:
		playerBank += coinValue + (streak * comboMulti * coinValue);
		bank_label.text = "$" + str(playerBank)
		streak += 1;
		result_label.text = "Heads" + "!".repeat(streak)
	else:
		result_label.text = "Tails"
		streak = 0
