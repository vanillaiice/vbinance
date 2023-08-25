module helpers

import math { fmod }

// round_step_size rounds a given number to a specific step size.
// Taken from python-binance by Sam McHardy, MIT License.
pub fn round_step_size(num f64, step_size f64) f64 {
	return num - fmod(num, step_size)
}
