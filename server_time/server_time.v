module server_time

import net.http
import json

struct Response {
	server_time i64 [json: serverTime]
}

pub fn get(server_base_endpoint string) i64 {
	resp := http.get('https://${server_base_endpoint}/api/v3/time') or { return 0 }
	resp_json := json.decode(Response, resp.body) or { return 0 }
	return resp_json.server_time
}
