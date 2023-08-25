module exchange_information

fn test_get() {
  url := 'testnet.binance.vision'
  pairs := ['TRXUSDT', 'BTCUSDT']
  
  _, _, code := get(url, pairs)
  assert code == 200
  
  s, _ := step_size(url, pairs)
  assert s[pairs[1]] == '0.00000100'
  assert s[pairs[0]] == '0.10000000'
}
