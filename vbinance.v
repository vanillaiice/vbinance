module vbinance

import spot.order
import spot.account
import server_time

pub struct Binance {
	server_base_endpoint string [required]
	symbol               string [required]
	secret_key           string
	api_key              string
}

pub fn new(server_base_endpoint string, symbol string, secret_key string, api_key string) &Binance {
	return &Binance{
		server_base_endpoint: server_base_endpoint
		symbol: symbol
		secret_key: secret_key
		api_key: api_key
	}
}

pub fn (b Binance) market_buy(quantity string) (string, string, int) {
	return order.market_buy(b.server_base_endpoint, b.secret_key, b.api_key, b.symbol,
		quantity)
}

pub fn (b Binance) market_sell(quantity string) (string, string, int) {
	return order.market_sell(b.server_base_endpoint, b.secret_key, b.api_key, b.symbol,
		quantity)
}

pub fn (b Binance) account_info() (account.Response, string, int) {
	return account.info(b.server_base_endpoint, b.secret_key, b.api_key)
}

pub fn (b Binance) account_info_pretty() string {
	return account.info_pretty(b.server_base_endpoint, b.secret_key, b.api_key)
}

pub fn (b Binance) server_time() !i64 {
	return server_time.get(b.server_base_endpoint)
}

/*
pub fn (b Binance) set_server_base_endpoint(server_base_endpoint string) {
	b.server_base_endpoint = server_base_endpoint
}

pub fn (b Binance) set_symbol(symbol string) {
	b.symbol = symbol
}

pub fn (b Binance) set_secret_key(secret_key string) {
	b.secret_key = secret_key
}

pub fn (b Binance) set_api_key(api_key string) {
	b.api_key = api_key
}
*/
