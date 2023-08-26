module server_time

fn test_get() {
	assert get('testnet.binance.vision')! != 0
}
