module order

import json
import net.http
import sign
import server_time as st

struct Response {
	symbol       string
	order_id     int             [json: orderId]
	executed_qty string          [json: executedQty]
	status       string
	fills        []struct {
		price            string
		qty              string
		commission       string
		commission_asset string [json: commissionAsset]
	}
}

pub fn market_buy(server_base_endpoint string, secret_key string, api_key string, symbol string, qty string) (string, string, int) {
	timestamp := st.get(server_base_endpoint)
	req := make_market_order_request(qty, 'BUY', symbol, timestamp)
	sig := sign.sign(secret_key, req)
	mut request := http.new_request(.post, 'https://${server_base_endpoint}/api/v3/order',
		'${req}&signature=${sig}')
	request.add_custom_header('X-MBX-APIKEY', api_key) or { return '', '${err}', 0 }

	resp := request.do() or { return '', '${err}', 0 }

	resp_json := json.decode(Response, resp.body.str()) or { return '', '${err}', 0 }

	return resp_json.status, resp.str(), resp.status_code
}

pub fn market_sell(server_base_endpoint string, secret_key string, api_key string, symbol string, qty string) (string, string, int) {
	timestamp := st.get(server_base_endpoint)
	req := make_market_order_request(qty, 'SELL', symbol, timestamp)
	sig := sign.sign(secret_key, req)
	mut request := http.new_request(.post, 'https://${server_base_endpoint}/api/v3/order',
		'${req}&signature=${sig}')
	request.add_custom_header('X-MBX-APIKEY', api_key) or { return '', '${err}', 0 }

	resp := request.do() or { return '', '${err}', 0 }

	resp_json := json.decode(Response, resp.body.str()) or { return '', '${err}', 0 }

	return resp_json.status, resp.str(), resp.status_code
}

fn make_market_order_request(qty string, side string, symbol string, timestamp i64) string {
	return 'side=${side}&symbol=${symbol}&quantity=${qty}&timestamp=${timestamp}&type=MARKET'
}
