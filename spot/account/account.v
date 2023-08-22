module account

import json
import net.http
import sign
import server_time as st

struct Response {
pub:
	balances []struct {
		asset string
		free  string
	}
}

pub fn info(server_base_endpoint string, secret_key string, api_key string) (Response, string, int) {
	timestamp := st.get(server_base_endpoint)
	req := 'timestamp=${timestamp}' 
	sig := sign.sign(secret_key, req)
	mut request := http.new_request(.get, 'https://${server_base_endpoint}/api/v3/account?${req}&signature=${sig}',
		'')
	request.add_custom_header('X-MBX-APIKEY', api_key) or { return Response{}, '${err}', 0 }

	resp := request.do() or { return Response{}, '${err}', 0 }

	resp_json := json.decode(Response, resp.body.str()) or { return Response{}, '${err}', 0 }

	return resp_json, resp.str(), resp.status_code
}

pub fn info_pretty(server_url string, secret_key string, api_key string) string {
	info_raw, err, _ := info(server_url, secret_key, api_key)
	
	if info_raw.balances.len == 0 {
		return '${err}'
	}
	
	mut info_pretty := []string{}

	for i in info_raw.balances {
		info_pretty << '${i.asset}: ${i.free}'
	}

	return info_pretty.join_lines()
}
