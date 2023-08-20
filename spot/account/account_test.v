module account

import os
import zztkm.vdotenv

fn test_info() {
	vdotenv.load()
	skey := os.getenv('SECRET_KEY')
	apikey := os.getenv('API_KEY')

	rj, r, sc := info('testnet.binance.vision', skey, apikey)

	assert sc == 200
	assert rj.balances[7].asset == 'XRP'
	assert rj.balances[7].free == '50000.00000000'

	println(rj)
	//println(r)
	println(sc)
}

fn test_info_pretty() {
	vdotenv.load()
	skey := os.getenv('SECRET_KEY')
	apikey := os.getenv('API_KEY')

	r := info_pretty('testnet.binance.vision', skey, apikey)

	println(r)
}
