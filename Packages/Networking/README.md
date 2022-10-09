# Networking

A package used to handle all HTTP method calls and parse the response.

## Details:

- **Minimum target:** iOS 15
- **Current coverage:** 100%

## Usage:

The `Networking` package exposes the `NetworkClient` protocol, as well as the `DefaultNetworkClient` implementation, which uses Apple's new `Async/Await` concurrency framework to handle asynchronous calls. 

The main purpose of the package is to handle the HTTP network calls, decode the response and handle potential networking errors.

The `NetworkClient` protocol is defined as such:

```swift
func get<T: Codable>(
    url: URL?,
    expecting type: T.Type
) async -> Result<T, Error>
```
