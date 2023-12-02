module order

import os
import zztkm.vdotenv
import helpers

const buy = 'BUY'
const sell = 'SELL'
const market = 'MARKET'
const limit = 'LIMIT'

fn test_place() {
	vdotenv.load('.env')
	skey := os.getenv('SECRET_KEY')
	apikey := os.getenv('API_KEY')

	// market buy
	mut options := {
		'side':     order.buy
		'symbol':   'TRXUSDT'
		'quantity': '${helpers.round_step_size(1002.44970703125, 0.1):.5f}'
		'type':     order.market
	}

	s, r, sc := place('testnet.binance.vision', skey, apikey, mut options)!

	assert s.status == 'FILLED'
	assert sc == 200

	// market sell
	mut options2 := {
		'side':     order.sell
		'symbol':   'TRXUSDT'
		'quantity': '${helpers.round_step_size(1002.44970703125, 0.1):.5f}'
		'type':     order.market
	}

	s2, r2, sc2 := place('testnet.binance.vision', skey, apikey, mut options2)!

	assert s2.status == 'FILLED'
	assert sc2 == 200

	// limit buy
	// limit sell
}

fn test_make_request() {
	m := {
		'side':      'SELL'
		'symbol':    'BTCUSDT'
		'quantity':  '1'
		'timestamp': '69420'
		'type':      'MARKET'
	}

	assert make_order_request(m) == 'side=SELL&symbol=BTCUSDT&quantity=1&timestamp=69420&type=MARKET'
}
