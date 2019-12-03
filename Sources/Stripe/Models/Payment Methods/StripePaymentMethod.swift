//
//  StripePaymentMethod.swift
//  Stripe
//
//  Created by Kristian Andersen on 03/12/2019.
//

import Foundation

/// The [PaymentMethod Object](https://stripe.com/docs/api/payment_methods/object).
public struct StripePaymentMethod: StripeModel {
	/// Unique identifier for the object.
	public var id: String
	/// String representing the object’s type. Objects of the same type share the same value.
	public var object: String
	/// Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
	public var billingDetails: StripeBillingDetails?
	/// If this is a `card` PaymentMethod, this hash contains details about the card.
	public var card: StripePaymentMethodCard?
	/// If this is a `card_present` PaymentMethod, this hash contains details about the Card Present payment method.
	/// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card_present) about possible values so this will remain nil/unimplemented.
	public var cardPresent: String? = nil
	/// Time at which the object was created. Measured in seconds since the Unix epoch.
	public var created: Date?
	/// The ID of the Customer to which this PaymentMethod is saved. This will not be set when the PaymentMethod has not been saved to a Customer.
	public var customer: String?
	/// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
	public var livemode: Bool?
	/// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
	public var metadata: [String: String]?
	/// The type of the PaymentMethod, one of `card` or `card_present`. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type.
	public var type: StripePaymentMethodType?

	public enum CodingKeys: String, CodingKey {
		case billingDetails = "billing_details"
		case cardPresent = "card_present"
		case id, object, card, created, customer, livemode, metadata, type
	}
}

public struct StripePaymentMethodCard: StripeModel {
	/// Card brand. Can be `amex`, `diners`, `discover`, `jcb`, `mastercard`, `unionpay`, `visa`, or `unknown`.
	public var brand: StripePaymentMethodCardBrand?
	/// Checks on Card address and CVC if provided.
	public var checks: StripePaymentMethodCardChecks?
	/// Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you’ve collected.
	public var country: String?
	/// Two-digit number representing the card’s expiration month.
	public var expMonth: Int?
	/// Four-digit number representing the card’s expiration year.
	public var expYear: Int?
	/// Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example.
	public var fingerprint: String?
	/// Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
	public var funding: StripeCardFundingType?
	// TODO: - Generated from. (it's repetative 🥴) https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-generated_from
	/// The last four digits of the card.
	public var last4: String?
	/// Contains details on how this Card maybe be used for 3D Secure authentication.
	public var threeDSecureUsage: StripePaymentMethodCardThreeDSecureUsage?
	/// If this Card is part of a card wallet, this contains the details of the card wallet.
	public var wallet: StripePaymentMethodCardWallet?

	public enum CodingKeys: String, CodingKey {
		case expMonth = "exp_month"
		case expYear = "exp_year"
		case threeDSecureUsage = "three_d_secure_usage"
		case brand, checks, country, funding, last4, wallet, fingerprint
	}
}

public enum StripePaymentMethodCardBrand: String, StripeModel {
	case amex
	case diners
	case discover
	case jcb
	case mastercard
	case unionpay
	case visa
	case unknown
}

public struct StripePaymentMethodCardChecks: StripeModel {
	/// If a address line1 was provided, results of the check, one of ‘pass’, ‘failed’, ‘unavailable’ or ‘unchecked’.
	public var addressLine1Check: StripeCardValidationCheck?
	/// If a address postal code was provided, results of the check, one of ‘pass’, ‘failed’, ‘unavailable’ or ‘unchecked’.
	public var addressPostalCodeCheck: StripeCardValidationCheck?
	/// If a CVC was provided, results of the check, one of ‘pass’, ‘failed’, ‘unavailable’ or ‘unchecked’.
	public var cvcCheck: StripeCardValidationCheck?

	public enum CodingKeys: String, CodingKey {
		case addressLine1Check = "address_line1_check"
		case addressPostalCodeCheck = "address_postal_code_check"
		case cvcCheck = "cvc_check"
	}
}

public struct StripePaymentMethodCardThreeDSecureUsage: StripeModel {
	/// Whether 3D Secure is supported on this card.
	public var supported: Bool?
}

public struct StripePaymentMethodCardWallet: StripeModel {
	/// If this is a `amex_express_checkout` card wallet, this hash contains details about the wallet.
	/// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-amex_express_checkout) about possible values so this will remain nil/unimplemented.
	public var amexExpressCheckout: String? = nil
	/// If this is a `apple_pay` card wallet, this hash contains details about the wallet.
	/// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-apple_pay) about possible values so this will remain nil/unimplemented.
	public var applePay: String? = nil
	/// (For tokenized numbers only.) The last four digits of the device account number.
	public var dynamicLast4: String?
	/// If this is a `google_pay` card wallet, this hash contains details about the wallet.
	/// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-google_pay) about possible values so this will remain nil/unimplemented.
	public var googlePay: String? = nil
	/// If this is a `masterpass` card wallet, this hash contains details about the wallet.
	public var masterpass: StripePaymentMethodCardWalletMasterPass?
	/// If this is a `samsung_pay` card wallet, this hash contains details about the wallet.
	/// Stripe does not [provide any details](https://stripe.com/docs/api/payment_methods/object#payment_method_object-card-wallet-samsung_pay) about possible values so this will remain nil/unimplemented.
	public var samsungPay: String? = nil
	/// The type of the card wallet, one of `amex_express_checkout`, `apple_pay`, `google_pay`, `masterpass`, `samsung_pay`, or `visa_checkout`. An additional hash is included on the Wallet subhash with a name matching this value. It contains additional information specific to the card wallet type.
	public var type: StripePaymentMethodCardWalletType?
	/// If this is a `visa_checkout` card wallet, this hash contains details about the wallet.
	public var visaCheckout: StripePaymentMethodCardWalletVisaCheckout?

	public enum CodingKeys: String, CodingKey {
		case amexExpressCheckout = "amex_express_checkout"
		case dynamicLast4 = "dynamic_last4"
		case applePay = "apple_pay"
		case googlePay = "google_pay"
		case samsungPay = "samsung_pay"
		case visaCheckout = "visa_checkout"
		case type, masterpass
	}
}

public struct StripePaymentMethodCardWalletMasterPass: StripeModel {
	/// Owner’s verified billing address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
	public var billingAddress: StripeAddress?
	/// Owner’s verified email. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
	public var email: String?
	/// Owner’s verified full name. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
	public var name: String?
	/// Owner’s verified shipping address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
	public var shippingAddress: StripeAddress?

	public enum CodingKeys: String, CodingKey {
		case billingAddress = "billing_address"
		case shippingAddress = "shipping_address"
		case email, name
	}
}

public enum StripePaymentMethodCardWalletType: String, StripeModel {
	case amexExpressCheckout = "amex_express_checkout"
	case applePay = "apple_pay"
	case googlePay = "google_pay"
	case masterpass
	case samsungPay = "samsung_pay"
	case visaCheckout = "visa_checkout"
}

public struct StripePaymentMethodCardWalletVisaCheckout: StripeModel {
	/// Owner’s verified billing address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
	public var billingAddress: StripeAddress?
	/// Owner’s verified email. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
	public var email: String?
	/// Owner’s verified full name. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
	public var name: String?
	/// Owner’s verified shipping address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
	public var shippingAddress: StripeAddress?

	public enum CodingKeys: String, CodingKey {
		case billingAddress = "billing_address"
		case shippingAddress = "shipping_address"
		case email, name
	}
}

public enum StripePaymentMethodType: String, StripeModel {
	case card
	case cardPresent = "card_present"
}

public struct StripePaymentMethodList: StripeModel {
	public var object: String
	public var data: [StripePaymentMethod]?
	public var hasMore: Bool?
	public var url: String?

	public enum CodingKeys: String, CodingKey {
		case object
		case hasMore = "has_more"
		case url
		case data
	}
}
