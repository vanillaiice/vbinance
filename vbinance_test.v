module vbinance

fn test_new() {
	url := 'testnet.binance.vision'
	secret_key := 'secret'
	api_key := 'api'

	b := new(url, secret_key, api_key)

	assert b.server_base_endpoint == url
	assert b.secret_key == secret_key
	assert b.api_key == api_key
}
