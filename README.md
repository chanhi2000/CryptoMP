# CryptoMP

Sample Crypto iOS/macOS Application Project 
> Created : 2021.04

## What's Used?

![shield-xcode][shield-xcode]
![shield-swift][shield-swift]


## Task(s) Completed

- [x] ~~Initialize Project~~
- [x] ~~Attach Crypto View, ViewModel~~
- [ ] Add Extra Feature(s)
   - [x] ~~Quit App~~

## Note

To run the app (without failure), check the following(s)

- is App's target to `macOS`?
- on macOS's `Signing & Capabilities`
	- `App Sandbox` > `Outgoing Connections (Client)` is enabled?

## References

- [CoinGaeko API][api-coingaeko]

[api-coingaeko]: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&sparkline=true&price_change_percentage=24h


[shield-xcode]: https://img.shields.io/badge/xcode-13.x-147EFB?logo=xcode&logoColor=147EFB&style=flat-square
[shield-swift]: https://img.shields.io/badge/swift-5.x-F05138?logo=swift&logoColor=F05138&style=flat-square

