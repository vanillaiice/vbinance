module account

import json
import net.http
import sign
import server_time as st

struct Response {
	balances []struct {
		asset string
		free  string
	}
}

pub fn info(server_url string, secret_key string, api_key string) !(Response, string, int) {
	req := 'timestamp=${st.get(server_url)!}'
	sig := sign.sign(secret_key, req)
	mut request := http.new_request(.get, 'https://${server_url}/api/v3/account?${req}&signature=${sig}',
		'')
	request.add_custom_header('X-MBX-APIKEY', api_key)!

	resp := request.do()!

	resp_json := json.decode(Response, resp.body.str())!

	return resp_json, resp.str(), resp.status_code
}

pub fn info_pretty(server_url string, secret_key string, api_key string) !string {
	info_raw, _, _ := info(server_url, secret_key, api_key)!
	mut info_pretty := []string{}

	for i in info_raw.balances {
		info_pretty << '${i.asset}: ${i.free}'
	}

	return info_pretty.join_lines()
}
