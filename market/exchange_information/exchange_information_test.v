module exchange_information

fn test_get() {
	url := 'testnet.binance.vision'
	pairs := ['TRXUSDT', 'BTCUSDT']

	_, _, code := get(url, pairs) or {
		eprintln('${err}')
		exit(1)
	}
	assert code == 200

	s, _ := step_size(url, pairs) or {
		eprintln('${err}')
		exit(1)
	}
	assert s[pairs[1]] == '0.00001000'
	assert s[pairs[0]] == '0.10000000'
}
