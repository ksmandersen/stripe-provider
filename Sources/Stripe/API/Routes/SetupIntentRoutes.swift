//
//  SetupIntentRoutes.swift
//  Stripe
//
//  Created by Kristian Andersen on 04/04/2020.
//

import Vapor

public protocol SetupIntentsRoutes {

	/// Creates a SetupIntent Object. After the SetupIntent is created, attach a payment method and confirm to collect any required permissions to charge the payment method later.
	/// - Parameter confirm: Set to true to attempt to confirm this SetupIntent immediately. This parameter defaults to false. If the payment method attached is a card, a return_url may be provided in case additional authentication is required.
	/// - Parameter customer: ID of the Customer this SetupIntent belongs to, if one exists. If present, payment methods used with this SetupIntent can only be attached to this Customer, and payment methods
	/// - Parameter description: An arbitrary string attached to the object. Often useful for displaying to users.
	/// - Parameter mandateData: This hash contains details about the Mandate to create. This parameter can only be used with `confirm=true`.
	/// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
	/// - Parameter onBehalfOf: The Stripe account ID for which this SetupIntent is created.
	/// - Parameter paymentMethod: ID of the payment method (a PaymentMethod, Card, or saved Source object) to attach to this SetupIntent.
	/// - Parameter paymentMethodOptions: Payment-method-specific configuration for this SetupIntent.
	/// - Parameter paymentMethodTypes: The list of payment method types that this SetupIntent is allowed to set up. If this is not provided, defaults to `[“card”]`. Valid payment method types include: `card` and `ideal`.
	/// - Parameter returnUrl: The URL to redirect your customer back to after they authenticate or cancel their payment on the payment method’s app or site. If you’d prefer to redirect to a mobile application, you can alternatively supply an application URI scheme. This parameter can only be used with `confirm=true`.
	/// - Parameter singleUse: If this hash is populated, this SetupIntent will generate a single_use Mandate on success.
	/// - Parameter usage: Indicates how the payment method is intended to be used in the future. If not provided, this value defaults to `off_session`.
	func create(confirm: Bool?,
				customer: String?,
				description: String?,
				mandateData: [String: Any]?,
				metadata: [String: String]?,
				onBehalfOf: String?,
				paymentMethod: String?,
				paymentMethodOptions: [String: Any]?,
				paymentMethodTypes: [String]?,
				returnUrl: String?,
				singleUse: [String: Any]?,
				usage: String?) throws -> Future<StripeSetupIntent>

	/// Retrieves the details of a SetupIntent that has previously been created.
	/// - Parameter intent: ID of the SetupIntent to retrieve.
	/// - Parameter clientSecret: The client secret of the SetupIntent. Required if a publishable key is used to retrieve the SetupIntent.
	func retrieve(intent: String, clientSecret: String?)  throws -> Future<StripeSetupIntent>

	/// Updates a SetupIntent object.
	/// - Parameter intent: ID of the SetupIntent to retrieve.
	/// - Parameter customer: ID of the Customer this SetupIntent belongs to, if one exists. If present, payment methods used with this SetupIntent can only be attached to this Customer, and payment methods attached to other Customers cannot be used with this SetupIntent.
	/// - Parameter description: An arbitrary string attached to the object. Often useful for displaying to users.
	/// - Parameter metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
	/// - Parameter paymentMethod: ID of the payment method (a PaymentMethod, Card, or saved Source object) to attach to this SetupIntent.
	/// - Parameter paymentMethodTypes: The list of payment method types (e.g. card) that this SetupIntent is allowed to set up. If this is not provided, defaults to [“card”].
	func update(intent: String,
				customer: String?,
				description: String?,
				metadata: [String: String]?,
				paymentMethod: String?,
				paymentMethodTypes: [String]?) throws -> Future<StripeSetupIntent>

	/// Confirm that your customer intends to set up the current or provided payment method. For example, you would confirm a SetupIntent when a customer hits the “Save” button on a payment method management page on your website.
	/// If the selected payment method does not require any additional steps from the customer, the SetupIntent will transition to the succeeded status.
	/// Otherwise, it will transition to the `requires_action` status and suggest additional actions via `next_action`. If setup fails, the SetupIntent will transition to the `requires_payment_method` status.
	/// - Parameter intent: ID of the SetupIntent to retrieve.
	/// - Parameter mandateData: This hash contains details about the Mandate to create
	/// - Parameter paymentMethod: ID of the payment method (a PaymentMethod, Card, or saved Source object) to attach to this SetupIntent.
	/// - Parameter paymentMethodOptions: Payment-method-specific configuration for this SetupIntent.
	/// - Parameter returnUrl: The URL to redirect your customer back to after they authenticate on the payment method’s app or site. If you’d prefer to redirect to a mobile application, you can alternatively supply an application URI scheme. This parameter is only used for cards and other redirect-based payment methods.
	func confirm(intent: String,
				 mandateData: [String: Any]?,
				 paymentMethod: String?,
				 paymentMethodOptions: [String: Any]?,
				 returnUrl: String?) throws -> Future<StripeSetupIntent>

	/// A SetupIntent object can be canceled when it is in one of these statuses: `requires_payment_method`, `requires_capture`, `requires_confirmation`, `requires_action`.
	/// Once canceled, setup is abandoned and any operations on the SetupIntent will fail with an error.
	/// - Parameter intent: ID of the SetupIntent to retrieve.
	/// - Parameter cancellationReason: Reason for canceling this SetupIntent. Possible values are `abandoned`, `requested_by_customer`, or `duplicate`.
	func cancel(intent: String, cancellationReason: StripeSetupIntentCancellationReason?) throws -> Future<StripeSetupIntent>

	/// Returns a list of SetupIntents.
	/// - Parameter filter: A dictionary that contains the filters. More info [here](https://stripe.com/docs/api/setup_intents/list).
	func listAll(filter: [String: Any]?) throws -> Future<StripeSetupIntentsList>
}

extension SetupIntentsRoutes {
	public func create(confirm: Bool? = nil,
					   customer: String? = nil,
					   description: String? = nil,
					   mandateData: [String: Any]? = nil,
					   metadata: [String: String]? = nil,
					   onBehalfOf: String? = nil,
					   paymentMethod: String? = nil,
					   paymentMethodOptions: [String: Any]? = nil,
					   paymentMethodTypes: [String]? = nil,
					   returnUrl: String? = nil,
					   singleUse: [String: Any]? = nil,
					   usage: String? = nil) throws -> Future<StripeSetupIntent> {
		return try create(confirm: confirm,
					  customer: customer,
					  description: description,
					  mandateData: mandateData,
					  metadata: metadata,
					  onBehalfOf: onBehalfOf,
					  paymentMethod: paymentMethod,
					  paymentMethodOptions: paymentMethodOptions,
					  paymentMethodTypes: paymentMethodTypes,
					  returnUrl: returnUrl,
					  singleUse: singleUse,
					  usage: usage)
	}

	public func retrieve(intent: String, clientSecret: String? = nil) throws -> Future<StripeSetupIntent> {
		return try retrieve(intent: intent, clientSecret: clientSecret)
	}

	public func update(intent: String,
					   customer: String? = nil,
					   description: String? = nil,
					   metadata: [String: String]? = nil,
					   paymentMethod: String? = nil,
					   paymentMethodTypes: [String]? = nil)  throws -> Future<StripeSetupIntent> {
		return try update(intent: intent,
					  customer: customer,
					  description: description,
					  metadata: metadata,
					  paymentMethod: paymentMethod,
					  paymentMethodTypes: paymentMethodTypes)
	}

	public func confirm(intent: String,
						mandateData: [String: Any]? = nil,
						paymentMethod: String? = nil,
						paymentMethodOptions: [String: Any]? = nil,
						returnUrl: String? = nil) throws -> Future<StripeSetupIntent> {
		return try confirm(intent: intent,
					   mandateData: mandateData,
					   paymentMethod: paymentMethod,
					   paymentMethodOptions: paymentMethodOptions,
					   returnUrl: returnUrl)
	}

	public func cancel(intent: String, cancellationReason: StripeSetupIntentCancellationReason? = nil) throws -> Future<StripeSetupIntent> {
		return try cancel(intent: intent, cancellationReason: cancellationReason)
	}

	public func listAll(filter: [String: Any]? = nil) throws -> Future<StripeSetupIntentsList> {
		return try listAll(filter: filter)
	}
}

public struct StripeSetupIntentsRoutes: SetupIntentsRoutes {
	private let request: StripeRequest

	init(request: StripeRequest) {
		self.request = request
	}

	public func create(confirm: Bool? = nil,
					   customer: String? = nil,
					   description: String? = nil,
					   mandateData: [String: Any]? = nil,
					   metadata: [String: String]? = nil,
					   onBehalfOf: String? = nil,
					   paymentMethod: String? = nil,
					   paymentMethodOptions: [String: Any]? = nil,
					   paymentMethodTypes: [String]? = nil,
					   returnUrl: String? = nil,
					   singleUse: [String: Any]? = nil,
					   usage: String? = nil) throws -> Future<StripeSetupIntent> {
		var body: [String: Any] = [:]

		if let confirm = confirm {
			body["confirm"] = confirm
		}

		if let customer = customer {
			body["customer"] = customer
		}

		if let description = description {
			body["description"] = description
		}

		if let mandateData = mandateData {
			mandateData.forEach { body["mandate_data[\($0)]"] = $1 }
		}

		if let metadata = metadata {
			metadata.forEach { body["metadata[\($0)]"] = $1 }
		}

		if let onBehalfOf = onBehalfOf {
			body["on_behalf_of"] = onBehalfOf
		}

		if let paymentMethod = paymentMethod {
			body["payment_method"] = paymentMethod
		}

		if let paymentMethodOptions = paymentMethodOptions {
			paymentMethodOptions.forEach { body["payment_method_options[\($0)]"] = $1 }
		}

		if let paymentMethodTypes = paymentMethodTypes {
			body["payment_method_types"] = paymentMethodTypes
		}

		if let returnUrl = returnUrl {
			body["return_url"] = returnUrl
		}

		if let singleUse = singleUse {
			singleUse.forEach { body["single_use[\($0)]"] = $1 }
		}

		if let usage = usage {
			body["usage"] = usage
		}

		return try request.send(method: .POST, path: StripeAPIEndpoint.setupIntents.endpoint,
								body: body.queryParameters)
	}

	public func retrieve(intent: String, clientSecret: String? = nil) throws -> Future<StripeSetupIntent> {
		var query: String = ""

		if let clientSecret = clientSecret {
			query = "client_secret=\(clientSecret)"
		}

		return try request.send(method: .GET, path: StripeAPIEndpoint.setupIntent(intent).endpoint, query: query)
	}

	public func update(intent: String,
					   customer: String? = nil,
					   description: String? = nil,
					   metadata: [String: String]? = nil,
					   paymentMethod: String? = nil,
					   paymentMethodTypes: [String]? = nil) throws -> Future<StripeSetupIntent> {
		var body: [String: Any] = [:]

		if let customer = customer {
			body["customer"] = customer
		}

		if let description = description {
			body["description"] = description
		}

		if let metadata = metadata {
			metadata.forEach { body["metadata[\($0)]"] = $1 }
		}

		if let paymentMethod = paymentMethod {
			body["payment_method"] = paymentMethod
		}

		if let paymentMethodTypes = paymentMethodTypes {
			body["payment_method_types"] = paymentMethodTypes
		}

		return try request.send(method: .POST, path: StripeAPIEndpoint.setupIntent(intent).endpoint,
								body: body.queryParameters)
	}

	public func confirm(intent: String,
						mandateData: [String: Any]? = nil,
						paymentMethod: String? = nil,
						paymentMethodOptions: [String: Any]? = nil,
						returnUrl: String? = nil) throws -> Future<StripeSetupIntent> {
		var body: [String: Any] = [:]

		if let mandateData = mandateData {
			mandateData.forEach { body["mandate_data[\($0)]"] = $1 }
		}

		if let paymentMethod = paymentMethod {
			body["payment_method"] = paymentMethod
		}

		if let paymentMethodOptions = paymentMethodOptions {
			paymentMethodOptions.forEach { body["payment_method_options[\($0)]"] = $1 }
		}

		if let returnUrl = returnUrl {
			body["return_url"] = returnUrl
		}

		return try request.send(method: .POST, path: StripeAPIEndpoint.setupIntentConfirm(intent).endpoint,
								body: body.queryParameters)
	}

	public func cancel(intent: String, cancellationReason: StripeSetupIntentCancellationReason? = nil) throws -> Future<StripeSetupIntent> {
		var body: [String: Any] = [:]

		if let cancellationReason = cancellationReason {
			body["cancellation_reason"] = cancellationReason.rawValue
		}

		return try request.send(method: .POST, path: StripeAPIEndpoint.setupIntentCancel(intent).endpoint,
								body: body.queryParameters)
	}

	public func listAll(filter: [String: Any]? = nil) throws  -> Future<StripeSetupIntentsList> {
		var queryParams = ""
		if let filter = filter {
			queryParams = filter.queryParameters
		}

		return try request.send(method: .GET, path: StripeAPIEndpoint.setupIntents.endpoint, query: queryParams)
	}
}

