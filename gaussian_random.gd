# Based on code from https://www.alanzucconi.com/2015/09/16/how-to-sample-from-a-gaussian-distribution
# By Alan Zucconi
# Converted to GDScript by Goral

class_name GaussianRandom

export(Resource) var rng = RandomNumberGenerator.new();

func uniform_gaussian() -> float:
	var v1: float
	var v2: float
	var s: float
	var firstPass = true

	while firstPass or s >= 1.0 or s == 0:
		v1 = 2.0 * rng.randf() - 1.0
		v2 = 2.0 * rng.randf() - 1.0
		s = v1 * v1 + v2 * v2
		firstPass = false

	s = sqrt((-2.0 * log(s)) / s)

	return v1 * s

func gaussian(mean: float, standard_deviation: float) -> float:
	return mean + uniform_gaussian() * standard_deviation

func gaussian_clamp(mean: float, standard_deviation: float, _min = null, _max = null) -> float:
	var x: float
	var firstPass = true

	while firstPass or (_min != null and x < _min) or (_max != null and x > _max):
		x = gaussian(mean, standard_deviation)
		firstPass = false
	return x
