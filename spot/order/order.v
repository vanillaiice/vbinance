module order

import json
import net.http
import sign
import server_time as st

struct Response {
pub:
	symbol               string
	order_id             int             [json: orderId]
	order_list_id        int             [json: orderListId]
	client_order_id      string          [json: clientOrderId]
	transact_time        i64             [json: transactTime]
	price                string
	orig_qty             string          [json: origQty]
	executed_qty         string          [json: executedQty]
	cumulative_quote_qty string          [json: cumulativeQuoteQty]
	status               string
	time_in_force        string          [json: timeInForce]
	@type                string
	side                 string
	working_time         i64             [json: working_time]
	fills                []struct {
	pub:
		price                      string
		qty                        string
		commission                 string
		commission_asset           string [json: commissionAsset]
		trade_id                   int    [json: tradeId]
		self_trade_prevention_mode string [json: selfTradePreventionMode]
	}
}

pub fn place(server_base_endpoint string, secret_key string, api_key string, mut options map[string]string) !(Response, string, int) {
	timestamp := st.get(server_base_endpoint) or { return err }
	options['timestamp'] = '${timestamp}'
	req := make_order_request(options)
	sig := sign.sign(secret_key, req)
	mut request := http.new_request(.post, 'https://${server_base_endpoint}/api/v3/order',
		'${req}&signature=${sig}')
	request.add_custom_header('X-MBX-APIKEY', api_key) or { return err }

	resp := request.do() or { return err }

	resp_json := json.decode(Response, resp.body.str()) or { return err }

	return resp_json, resp.body.str(), resp.status_code
}

fn make_order_request(m map[string]string) string {
	mut request := ''
	for k, v in m {
		request += '${k}=${v}&'
	}
	return request.all_before_last('&')
}
