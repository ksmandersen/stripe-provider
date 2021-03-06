# StripeProvider

![Swift](http://img.shields.io/badge/swift-5.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-4.0-brightgreen.svg)


### StripeProvider is a Vapor wrapper around [StripeKit](https://github.com/vapor-community/StripeKit)

## Usage guide
In your `Package.swift` file, add the following

~~~~swift
.package(url: "https://github.com/vapor-community/stripe-provider.git", from: "3.0.0")
~~~~

Register the configuration and the provider in `configure.swift`
~~~~swift
import Stripe

let stripeConfiguration = StripeConfiguration(apiKey: "sk_live_1234")

services.register(config)
try services.register(StripeProvider())
~~~~

Now to make a charge
~~~~swift
import Stripe

struct ChargeToken: Content {
    var stripeToken: String
}

func chargeCustomer(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
    return try req.content.decode(ChargeToken.self).flatMap { charge in
        return try req.make(StripeClient.self).charge.create(amount: 2500, currency: .usd, source: charge.stripeToken).map { stripeCharge in
            if stripeCharge.status == .success {
                return .ok
            } else {
                print("Stripe charge status: \(stripeCharge.status.rawValue)")
                return .badRequest
            }
        }
    }
}
~~~~

## License

Vapor Stripe Provider is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Want to help?
Feel free to submit a pull request whether it's a clean up, a new approach to handling things, adding a new part of the API, or even if it's just a typo. All help is welcomed! 😀
