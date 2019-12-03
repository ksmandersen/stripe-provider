//
//  PaymentMethodRoutes.swift
//  Stripe
//
//  Created by Kristian Andersen on 03/12/2019.
//

import Foundation
import Vapor

public protocol PaymentMethodRoutes {
	/// Creates a PaymentMethod object. Read the Stripe.js reference to learn how to create PaymentMethods via Stripe.js.
	///
	/// - Parameters:
	///   - type: The type of the PaymentMethod. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type. Required unless `payment_method` is specified (see the Shared PaymentMethods guide)
	///   - billingDetails: Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
	///   - card: If this is a `card` PaymentMethod, this hash contains the user’s card details. For backwards compatibility, you can alternatively provide a Stripe token (e.g., for Apple Pay, Amex Express Checkout, or legacy Checkout) into the card hash with format `card: {token: "tok_visa"}`. When creating with a card number, you must meet the requirements for PCI compliance. We strongly recommend using Stripe.js instead of interacting with this API directly.
	///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
	/// - Returns: A `StripePaymentMethod`.
	func create(type: StripePaymentMethodType,
				billingDetails: [String: Any]?,
				card: [String: Any]?,
				metadata: [String: String]?) throws -> Future<StripePaymentMethod>

	/// Retrieves a PaymentMethod object.
	///
	/// - Parameter paymentMethod: The ID of the PaymentMethod.
	/// - Returns: A `StripePaymentMethod`.
	func retrieve(paymentMethod: String) throws -> Future<StripePaymentMethod>

	/// Updates a PaymentMethod object. A PaymentMethod must be attached a customer to be updated.
	///
	/// - Parameters:
	///   - paymentMethod: The ID of the PaymentMethod to be updated.
	///   - billingDetails: Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
	///   - card: If this is a `card` PaymentMethod, this hash contains the user’s card details. For backwards compatibility, you can alternatively provide a Stripe token (e.g., for Apple Pay, Amex Express Checkout, or legacy Checkout) into the card hash with format `card: {token: "tok_visa"}`. When creating with a card number, you must meet the requirements for PCI compliance. We strongly recommend using Stripe.js instead of interacting with this API directly.
	///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
	/// - Returns: A `StripePaymentMethod`.
	func update(paymentMethod: String,
				billingDetails: [String: Any]?,
				card: [String: Any]?,
				metadata: [String: String]?) throws -> Future<StripePaymentMethod>

	/// Returns a list of PaymentMethods for a given Customer
	///
	/// - Parameters:
	///   - customer: The ID of the customer whose PaymentMethods will be retrieved.
	///   - type: A required filter on the list, based on the object type field.
	///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/payment_methods/list)
	/// - Returns: A `StripePaymentMethodList`.
	func listAll(customer: String,
				 type: StripePaymentMethodType,
				 filter: [String: Any]?) throws -> Future<StripePaymentMethodList>

	/// Attaches a PaymentMethod object to a Customer.
	///
	/// - Parameters:
	///   - paymentMethod: The PaymentMethod to attach to the customer.
	///   - customer: The ID of the customer to which to attach the PaymentMethod.
	/// - Returns: A `StripePaymentMethod`.
	func attach(paymentMethod: String, customer: String) throws -> Future<StripePaymentMethod>

	/// Detaches a PaymentMethod object from a Customer.
	///
	/// - Parameter paymentMethod: The PaymentMethod to detach from the customer.
	/// - Returns: A `StripePaymentMethod`.
	func detach(paymentMethod: String) throws -> Future<StripePaymentMethod>
}

extension PaymentMethodRoutes {
	public func create(type: StripePaymentMethodType,
					   billingDetails: [String: Any]? = nil,
					   card: [String: Any]? = nil,
					   metadata: [String: String]? = nil) throws -> Future<StripePaymentMethod> {
		return try create(type: type,
					  billingDetails: billingDetails,
					  card: card,
					  metadata: metadata)
	}

	public func retrieve(paymentMethod: String) throws -> Future<StripePaymentMethod> {
		return try retrieve(paymentMethod: paymentMethod)
	}

	public func update(paymentMethod: String,
					   billingDetails: [String: Any]? = nil,
					   card: [String: Any]? = nil,
					   metadata: [String: String]? = nil) throws -> Future<StripePaymentMethod> {
		return try update(paymentMethod: paymentMethod,
					  billingDetails: billingDetails,
					  card: card,
					  metadata: metadata)
	}

	public func listAll(customer: String,
						type: StripePaymentMethodType,
						filter: [String: Any]? = nil) throws -> Future<StripePaymentMethodList> {
		return try listAll(customer: customer,
					   type: type,
					   filter: filter)
	}

	public func attach(paymentMethod: String, customer: String) throws -> Future<StripePaymentMethod> {
		return try attach(paymentMethod: paymentMethod, customer: customer)
	}

	public func detach(paymentMethod: String) throws -> Future<StripePaymentMethod> {
		return try detach(paymentMethod: paymentMethod)
	}
}

public struct StripePaymentMethodRoutes: PaymentMethodRoutes {
	private let request: StripeRequest

	init(request: StripeRequest) {
		self.request = request
	}

	public func create(type: StripePaymentMethodType,
					   billingDetails: [String: Any]?,
					   card: [String: Any]?,
					   metadata: [String: String]?) throws -> Future<StripePaymentMethod> {
		var body: [String: Any] = ["type": type.rawValue]

		if let billingDetails = billingDetails {
			billingDetails.forEach { body["billing_details[\($0)]"] = $1 }
		}

		if let card = card {
			card.forEach { body["card[\($0)]"] = $1 }
		}

		if let metadata = metadata {
			metadata.forEach { body["metadata[\($0)]"] = $1 }
		}

		return try request.send(method: .POST, path: StripeAPIEndpoint.paymentMethod.endpoint, body: body.queryParameters)
	}

	public func retrieve(paymentMethod: String) throws -> Future<StripePaymentMethod> {
		return try request.send(method: .GET, path: StripeAPIEndpoint.paymentMethods(paymentMethod).endpoint)
	}

	public func update(paymentMethod: String,
					   billingDetails: [String: Any]?,
					   card: [String: Any]?,
					   metadata: [String: String]?) throws -> Future<StripePaymentMethod> {
		var body: [String: Any] = [:]

		if let billingDetails = billingDetails {
			billingDetails.forEach { body["billing_details[\($0)]"] = $1 }
		}

		if let card = card {
			card.forEach { body["card[\($0)]"] = $1 }
		}

		if let metadata = metadata {
			metadata.forEach { body["metadata[\($0)]"] = $1 }
		}

		return try request.send(method: .POST, path: StripeAPIEndpoint.paymentMethods(paymentMethod).endpoint, body: body.queryParameters)
	}

	public func listAll(customer: String, type: StripePaymentMethodType, filter: [String: Any]?) throws -> Future<StripePaymentMethodList> {
		var queryParams = "customer=\(customer)&type=\(type.rawValue)"
		if let filter = filter {
			queryParams += "&" + filter.queryParameters
		}

		return try request.send(method: .GET, path: StripeAPIEndpoint.paymentMethod.endpoint, query: queryParams)
	}

	public func attach(paymentMethod: String, customer: String) throws -> Future<StripePaymentMethod> {
		let body: [String: Any] = ["customer": customer]
		return try request.send(method: .POST, path: StripeAPIEndpoint.paymentMethodsAttach(paymentMethod).endpoint, body: body.queryParameters)
	}

	public func detach(paymentMethod: String) throws -> Future<StripePaymentMethod> {
		return try request.send(method: .POST, path: StripeAPIEndpoint.paymentMethodsDetach(paymentMethod).endpoint)
	}
}
