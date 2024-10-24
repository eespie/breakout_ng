extends Node

var rng = RandomNumberGenerator.new()


func get_value(minimum: float, peak: float, maximum: float):
	var v: float = rng.randf_range(minimum, maximum)
	if v < (peak - minimum) / (maximum - minimum):
		return minimum + sqrt(v * (maximum - minimum) * (peak - minimum))
	return maximum - sqrt((1.0 - v) * (maximum - minimum) * (maximum - peak))
