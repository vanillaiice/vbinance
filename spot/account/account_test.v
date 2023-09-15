module account

import os
import zztkm.vdotenv

fn test_info() {
	vdotenv.load()
	skey := os.getenv('SECRET_KEY')
	apikey := os.getenv('API_KEY')

	rj, r, sc := info('testnet.binance.vision', skey, apikey)!

	assert sc == 200
	assert rj.balances[0].asset == 'BNB'
	assert rj.balances[0].free == '2.00000000'
}

fn test_info_pretty() {
	vdotenv.load()
	skey := os.getenv('SECRET_KEY')
	apikey := os.getenv('API_KEY')

	r := info_pretty('testnet.binance.vision', skey, apikey)!

	assert r != ''
}
