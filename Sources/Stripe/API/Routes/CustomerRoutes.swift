//
//  CustomerRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import Vapor

public protocol CustomerRoutes {
	func create(accountBalance: Int?, coupon: String?, description: String?, email: String?, invoicePrefix: String?, invoiceSettings: [String: Any]?, metadata: [String: String]?, shipping: [String: Any]?, source: Any?, paymentMethod: String?, taxInfo: [String: String]?) throws -> Future<StripeCustomer>
    func retrieve(customer: String) throws -> Future<StripeCustomer>
    func update(customer: String, accountBalance: Int?, businessVatId: String?, coupon: String?, defaultSource: String?, description: String?, email: String?, invoiceSettings: [String: Any]?, metadata: [String: String]?, shipping: ShippingLabel?, source: Any?) throws -> Future<StripeCustomer>
    func delete(customer: String) throws -> Future<StripeDeletedObject>
    func listAll(filter: [String: Any]?) throws -> Future<StripeCustomersList>
    func addNewSource(customer: String, source: String, toConnectedAccount: String?) throws -> Future<StripeSource>
    func addNewBankAccountSource(customer: String, source: Any, toConnectedAccount: String?, metadata: [String: String]?) throws -> Future<StripeBankAccount>
    func addNewCardSource(customer: String, source: Any, toConnectedAccount: String?, metadata: [String : String]?) throws -> Future<StripeCard>
    func deleteSource(customer: String, source: String) throws -> Future<StripeDeletedObject>
    func deleteDiscount(customer: String) throws -> Future<StripeDeletedObject>
}

extension CustomerRoutes {
    public func create(accountBalance: Int? = nil,
                       coupon: String? = nil,
                       description: String? = nil,
                       email: String? = nil,
                       invoicePrefix: String? = nil,
                       invoiceSettings: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       shipping: [String: Any]? = nil,
                       source: Any? = nil,
					   paymentMethod: String? = nil,
                       taxInfo: [String: String]? = nil) throws -> Future<StripeCustomer> {
        return try create(accountBalance: accountBalance,
                          coupon: coupon,
                          description: description,
                          email: email,
                          invoicePrefix: invoicePrefix,
                          invoiceSettings: invoiceSettings,
                          metadata: metadata,
                          shipping: shipping,
                          source: source,
						  paymentMethod: paymentMethod,
                          taxInfo: taxInfo)
    }
    
    public func retrieve(customer: String) throws -> Future<StripeCustomer> {
        return try retrieve(customer: customer)
    }
    
    public func update(customer: String,
                       accountBalance: Int? = nil,
                       businessVatId: String? = nil,
                       coupon: String? = nil,
                       defaultSource: String? = nil,
                       description: String? = nil,
                       email: String? = nil,
					   invoiceSettings: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       shipping: ShippingLabel? = nil,
                       source: Any? = nil) throws -> Future<StripeCustomer> {
        return try update(customer: customer,
                          accountBalance: accountBalance,
                          businessVatId: businessVatId,
                          coupon: coupon,
                          defaultSource: defaultSource,
                          description: description,
                          email: email,
						  invoiceSettings: invoiceSettings,
                          metadata: metadata,
                          shipping: shipping,
                          source: source)
    }
    
    public func delete(customer: String) throws -> Future<StripeDeletedObject> {
        return try delete(customer: customer)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> Future<StripeCustomersList> {
        return try listAll(filter: filter)
    }
    
    public func addNewSource(customer: String, source: String, toConnectedAccount: String? = nil) throws -> Future<StripeSource> {
        return try addNewSource(customer: customer, source: source, toConnectedAccount: toConnectedAccount)
    }
    
    public func addNewBankAccountSource(customer: String, source: Any, toConnectedAccount: String? = nil, metadata: [String : String]? = nil) throws -> Future<StripeBankAccount> {
        return try addNewBankAccountSource(customer: customer, source: source, toConnectedAccount: toConnectedAccount, metadata: metadata)
    }
    
    public func addNewCardSource(customer: String, source: Any, toConnectedAccount: String? = nil, metadata: [String : String]? = nil) throws -> Future<StripeCard> {
        return try addNewCardSource(customer: customer, source: source, toConnectedAccount: toConnectedAccount, metadata: metadata)
    }
    
    public func deleteSource(customer: String, source: String) throws -> Future<StripeDeletedObject> {
        return try deleteSource(customer: customer, source: source)
    }
    
    public func deleteDiscount(customer: String) throws -> Future<StripeDeletedObject> {
        return try deleteDiscount(customer: customer)
    }
}


public struct StripeCustomerRoutes: CustomerRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Create a customer
    /// [Learn More →](https://stripe.com/docs/api/curl#create_customer)
    public func create(accountBalance: Int?,
                       coupon: String?,
                       description: String?,
                       email: String?,
                       invoicePrefix: String?,
                       invoiceSettings: [String: Any]?,
                       metadata: [String: String]?,
                       shipping: [String: Any]?,
                       source: Any?,
					   paymentMethod: String?,
                       taxInfo: [String: String]?) throws -> Future<StripeCustomer> {
        var body: [String: Any] = [:]
        
        if let accountBalance = accountBalance {
            body["account_balance"] = accountBalance
        }
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let invoicePrefix = invoicePrefix {
            body["invoice_prefix"] = invoicePrefix
        }
        
        if let invoiceSettings = invoiceSettings {
            invoiceSettings.forEach { body["invoice_settings[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let shipping = shipping {
            shipping.forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let tokenSource = source as? String {
            body["source"] = tokenSource
        }

		if let paymentMethodId = paymentMethod {
			body["payment_method"] = paymentMethodId
		}
        
        if let dictionarySource = source as? [String: Any] {
            dictionarySource.forEach { body["source[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.customers.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve customer
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_customer)
    public func retrieve(customer: String) throws -> Future<StripeCustomer> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.customer(customer).endpoint)
    }
    
    /// Update customer
    /// [Learn More →](https://stripe.com/docs/api/curl#update_customer)
    public func update(customer: String,
                       accountBalance: Int?,
                       businessVatId: String?,
                       coupon: String?,
                       defaultSource: String?,
                       description: String?,
                       email: String?,
					   invoiceSettings: [String: Any]?,
                       metadata: [String: String]?,
                       shipping: ShippingLabel?,
                       source: Any?) throws -> Future<StripeCustomer> {
        var body: [String: Any] = [:]
        
        if let accountBalance = accountBalance {
            body["account_balance"] = accountBalance
        }
        
        if let businessVatId = businessVatId {
            body["business_vat_id"] = businessVatId
        }
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let defaultSource = defaultSource {
            body["default_source"] = defaultSource
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let email = email {
            body["email"] = email
        }

		if let invoiceSettings = invoiceSettings {
			invoiceSettings.forEach { body["invoice_settings[\($0)]"] = $1 }
		}
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let shipping = shipping {
            try shipping.toEncodedDictionary().forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let tokenSource = source as? String {
            body["source"] = tokenSource
        }
        
        if let cardDictionarySource = source as? [String: Any] {
            cardDictionarySource.forEach { body["source[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.customer(customer).endpoint, body: body.queryParameters)
    }
    
    /// Delete a customer
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_customer)
    public func delete(customer: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.customer(customer).endpoint)
    }
    
    /// List all customers
    /// [Learn More →](https://stripe.com/docs/api/curl#list_customers)
    public func listAll(filter: [String: Any]?) throws -> Future<StripeCustomersList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return try request.send(method: .GET, path: StripeAPIEndpoint.customers.endpoint, query: queryParams)
    }
    
    /// Attach a source
    /// [Learn More →](https://stripe.com/docs/api/curl#attach_source)
    public func addNewSource(customer: String, source: String, toConnectedAccount: String?) throws -> Future<StripeSource> {
        let body: [String: Any] = ["source": source]
        var headers: HTTPHeaders = [:]
        
        if let connectedAccount = toConnectedAccount {
            headers.add(name: .stripeAccount, value: connectedAccount)
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.customerSources(customer).endpoint, body: body.queryParameters, headers: headers)
    }
    
    /// Create a bank account
    /// [Learn More →](https://stripe.com/docs/api/curl#customer_create_bank_account)
    public func addNewBankAccountSource(customer: String, source: Any, toConnectedAccount: String?, metadata: [String : String]?) throws -> Future<StripeBankAccount> {
        var body: [String: Any] = [:]
        var headers: HTTPHeaders = [:]
        
        if let connectedAccount = toConnectedAccount {
            headers.add(name: .stripeAccount, value: connectedAccount)
        }
        
        if let source = source as? String {
            body["source"] = source
        }
        
        if let source = source as? [String: Any] {
            source.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.customerSources(customer).endpoint, body: body.queryParameters, headers: headers)
    }
    
    /// Create a card
    /// [Learn More →](https://stripe.com/docs/api/curl#create_card)
    public func addNewCardSource(customer: String, source: Any, toConnectedAccount: String?, metadata: [String : String]?) throws -> Future<StripeCard> {
        var body: [String: Any] = [:]
        var headers: HTTPHeaders = [:]
        
        if let connectedAccount = toConnectedAccount {
            headers.add(name: .stripeAccount, value: connectedAccount)
        }
        
        if let source = source as? String {
            body["source"] = source
        }
        
        if let source = source as? [String: Any] {
            source.forEach { body["source[\($1)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.customerSources(customer).endpoint, body: body.queryParameters, headers: headers)
    }

    /// Detach a source
    /// [Learn More →](https://stripe.com/docs/api/curl#detach_source)
    public func deleteSource(customer: String, source: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.customerDetachSources(customer, source).endpoint)
    }
    
    /// Delete a customer discount
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_discount)
    public func deleteDiscount(customer: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.customerDiscount(customer).endpoint)
    }
}
