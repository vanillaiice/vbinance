# Binance Connector V

V module to connect with Binance API.

## Features (WIP)

- sign requests with HMAC-SHA-256
- get server time
- get account info
- buy and sell spot market orders

## Installation

You can install this module using v.

```
v install vanillaiice.vbinance
```

You can then import it in your project by doing:

```
import vanillaiice.vbinance
```

Also, you can add in your v.mod file:

```
dependencies: ['vanillaiice.vbinance']
```

## Development dependencies

[zztkm.vdotenv](https://github.com/zztkm/vdotenv)

## Test

To run tests, make sure you have zzktm.vdotenv installed, and .env file containting your Binance secret key and api key **for testnet**.

```
v test .
```

## Author

vanillaiice

## License

BSD-3-Clause
