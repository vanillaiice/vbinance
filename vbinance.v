module vbinance

import spot.order
import spot.account
import market.exchange_information as exinfo
import server_time
import helpers

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

pub fn (b Binance) market_buy(quantity string) !(string, string, int) {
	return order.market_buy(b.server_base_endpoint, b.secret_key, b.api_key, b.symbol,
		quantity) or { return err }
}

pub fn (b Binance) market_sell(quantity string) !(string, string, int) {
	return order.market_sell(b.server_base_endpoint, b.secret_key, b.api_key, b.symbol,
		quantity) or { return err }
}

pub fn (b Binance) account_info() !(account.Response, string, int) {
	return account.info(b.server_base_endpoint, b.secret_key, b.api_key) or { return err }
}

pub fn (b Binance) account_info_pretty() !string {
	return account.info_pretty(b.server_base_endpoint, b.secret_key, b.api_key) or { return err }
}

pub fn (b Binance) exchange_info(symbols []string) !(exinfo.Response, string, int) {
	return exinfo.get(b.server_base_endpoint, symbols) or { return err }
}

pub fn (b Binance) step_size(symbols []string) !(map[string]string, string) {
	return exinfo.step_size(b.server_base_endpoint, symbols) or { return err }
}

pub fn (b Binance) server_time() !i64 {
	return server_time.get(b.server_base_endpoint) or { return err }
}

pub fn round_step_size(quantity f64, step_size f64) f64 {
	return helpers.round_step_size(quantity, step_size)
}
