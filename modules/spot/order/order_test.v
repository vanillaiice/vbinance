module order

import os
import zztkm.vdotenv

fn test_market_sell() {
	vdotenv.load('.env')
	skey := os.getenv('SECRET_KEY')
	apikey := os.getenv('API_KEY')

	s, r, sc := market_sell('testnet.binance.vision', skey, apikey, 'TRXUSDT', '500')!

	assert s == 'FILLED'
	assert sc == 200
	
	println('status: ${s}')
	println('status code: ${sc}')
	//println('resp: ${rb}')
}

fn test_market_buy() {
	vdotenv.load('.env')
	skey := os.getenv('SECRET_KEY')
	apikey := os.getenv('API_KEY')

	s, r, sc := market_buy('testnet.binance.vision', skey, apikey, 'TRXUSDT', '500')!

	assert s == 'FILLED'
	assert sc == 200
	
	println('status: ${s}')
	//println('resp: ${rb}')
}

fn test_make_market_order_request() {
	assert make_market_order_request('1', 'SELL', 'BTCUSDT', '69420') == 'side=SELL&symbol=BTCUSDT&quantity=1&timestamp=69420&type=MARKET'
}
