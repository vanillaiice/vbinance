module vbinance

fn test_new() {
	url := 'testnet.binance.vision'
	symbol := 'TRXUSDT'
	secret_key := 'secret'
	api_key := 'api'

	b := new(url, symbol, secret_key, api_key)

	assert b.server_base_endpoint == url
	assert b.symbol == symbol
	assert b.secret_key == secret_key
	assert b.api_key == api_key
}
