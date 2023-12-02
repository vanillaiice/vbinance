module exchange_information

import net.http
import json

struct Response {
pub:
	timezone         string
	server_time      i64               @[json: serverTime]
	rate_limits      []RateLimits      @[json: rateLimits]
	exchange_filters []ExchangeFilters @[json: exchangeFilters]
	symbols          []Symbols
}

struct RateLimits {
pub:
	rate_limit_type string @[json: rateLimitType]
	interval        string
	interval_num    int    @[json: intervalNum]
	limit           int
}

struct ExchangeFilters {}

struct Symbols {
pub:
	symbol                              string
	status                              string
	base_asset                          string    @[json: baseAsset]
	base_asset_precision                int       @[json: baseAssetPrecision]
	quote_asset                         string    @[json: quoteAsset]
	quote_precision                     int       @[json: quoteAssetPrecision]
	quote_asset_precision               int       @[json: quoteAssetPrecision]
	order_types                         []string  @[json: orderTypes]
	iceberg_allowed                     bool      @[json: icebergAllowed]
	oco_allowed                         bool      @[json: ocoAllowed]
	quote_order_qty_market_allowed      bool      @[json: quoteOrderQtyMarketAllowed]
	allow_trailing_stop                 bool      @[json: allowTrailingStop]
	cancel_replace_allowed              bool      @[json: cancelReplaceAllowed]
	is_spot_trading_allowed             bool      @[json: isSpotTradingAllowed]
	is_margin_trading_allowed           bool      @[json: isMarginTradingAllowed]
	filters                             []Filters
	permissions                         []string
	default_self_trade_prevention_mode  string    @[json: defaultSelfTradePreventionMode]
	allowed_self_trade_prevention_modes []string  @[json: allowedSelfTradePreventionModes]
}

struct Filters {
	filter_type              string @[json: filterType]
	price_filter             string @[json: priceFilter]
	min_price                string @[json: minPrice]
	max_price                string @[json: maxPrice]
	tick_size                string @[json: tickSize]
	min_qty                  string @[json: minQty]
	max_qty                  string @[json: maxQty]
	step_size                string @[json: stepSize]
	limit                    int
	min_trailing_above_delta int    @[json: minTrailingAboveDelta]
	max_trailing_above_delta int    @[json: maxTrailingAboveDelta]
	min_trailing_below_delta int    @[json: minTrailingBelowDelta]
	max_trailing_below_delta int    @[json: maxTrailingBelowDelta]
	bid_multiplier_up        string @[json: bidMultiplierUp]
	bid_multiplier_down      string @[json: bidMultiplierDown]
	ask_multiplier_up        string @[json: askMultiplierUp]
	ask_multiplier_down      string @[json: askMultiplierDown]
	avg_price_mins           int    @[json: avgPriceMins]
	min_notional             string @[json: minNotional]
	apply_min_to_market      bool   @[json: applyMinToMarket]
	max_notional             string @[json: applyMaxToMarket]
	max_num_orders           int    @[json: maxNumOrders]
	max_num_algo_orders      int    @[json: maxNumAlgoOrders]
}

pub fn get(server_base_endpoint string, symbols []string) !(Response, string, int) {
	mut data := ''

	if symbols.len == 1 {
		data = '?symbol=${symbols[0]}'
	} else if symbols.len > 1 {
		s := symbols.str().replace("'", '"').replace(' ', '')
		data = '?symbols=${s}'
	}

	resp := http.get('https://${server_base_endpoint}/api/v3/exchangeInfo${data}') or { return err }
	resp_json := json.decode(Response, resp.body) or { return err }

	return resp_json, resp.body.str(), resp.status_code
}

pub fn step_size(server_base_endpoint string, symbols []string) !(map[string]string, string) {
	info, resp, _ := get(server_base_endpoint, symbols) or { return err }
	mut step_sizes := map[string]string{}

	for s in info.symbols {
		step_sizes[s.symbol] = s.filters[1].step_size
	}

	return step_sizes, resp
}
