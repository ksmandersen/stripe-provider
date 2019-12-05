//
//  Invoice.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/4/17.
//
//

import Foundation

/**
Invoice object
https://stripe.com/docs/api#invoice_object
*/

public struct StripeInvoice: StripeModel {
	public var id: String?
	public var object: String
	public var amountDue: Int?
	public var amountPaid: Int?
	public var amountRemanining: Int?
	public var applicationFee: Int?
	public var attemptCount: Int?
	public var attempted: Bool?
	public var autoAdvance: Bool?
	public var billing: String?
	public var billingReason: StripeBillingReason?
	public var charge: String?
	public var closed: Bool?
	public var currency: StripeCurrency?
	public var customer: String?
	public var created: Date?
	public var defaultSource: String?
	public var description: String?
	public var discount: StripeDiscount?
	public var dueDate: Date?
	public var endingBalance: Int?
	public var forgiven: Bool?
	public var hostedInvoiceUrl: String?
	public var invoicePdf: String?
	public var lines: InvoiceLineGroup?
	public var livemode: Bool?
	public var metadata: [String: String]
	public var nextPaymentAttempt: Date?
	public var number: String?
	public var paid: Bool?
	public var paymentIntent: StripePaymentIntent?
	public var paymentIntentId: String?
	public var periodEnd: Date?
	public var periodStart: Date?
	public var receiptNumber: String?
	public var startingBalance: Int?
	public var statementDescriptor: String?
	public var status: StripeInvoiceStatus?
	public var statusTransitions: StripeInvoiceStatusTransitions?
	public var subscription: String?
	public var subscriptionProrationDate: Int?
	public var subtotal: Int?
	public var total: Int?
	public var tax: Int?
	public var taxPercent: Decimal?
	public var webhooksDeliveredAt: Date?

	public enum CodingKeys: String, CodingKey {
		case id
		case object
		case amountDue = "amount_due"
		case amountPaid = "amount_paid"
		case amountRemanining = "amount_remaining"
		case applicationFee = "application_fee_amount"
		case attemptCount = "attempt_count"
		case attempted
		case autoAdvance = "auto_advance"
		case billing
		case billingReason = "billing_reason"
		case charge
		case closed
		case currency
		case customer
		case created
		case defaultSource = "default_source"
		case description
		case discount
		case dueDate = "due_date"
		case endingBalance = "ending_balance"
		case forgiven
		case hostedInvoiceUrl = "hosted_invoice_url"
		case invoicePdf = "invoice_pdf"
		case lines
		case livemode
		case metadata
		case nextPaymentAttempt = "next_payment_attempt"
		case number
		case paid
		case paymentIntent = "payment_intent"
		case periodEnd = "period_end"
		case periodStart = "period_start"
		case receiptNumber = "receipt_number"
		case startingBalance = "starting_balance"
		case statementDescriptor = "statement_descriptor"
		case status
		case statusTransitions = "status_transitions"
		case subscription
		case subscriptionProrationDate = "subscription_proration_date"
		case subtotal
		case total
		case tax
		case taxPercent = "tax_percent"
		case webhooksDeliveredAt = "webhooks_delivered_at"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.object = try container.decode(String.self, forKey: .object)

		self.amountDue = try container.decodeIfPresent(Int.self, forKey: .amountDue)
		self.amountPaid = try container.decodeIfPresent(Int.self, forKey: .amountPaid)
		self.amountRemanining = try container.decodeIfPresent(Int.self, forKey: .amountRemanining)
		self.applicationFee = try container.decodeIfPresent(Int.self, forKey: .applicationFee)
		self.attemptCount = try container.decodeIfPresent(Int.self, forKey: .attemptCount)
		self.attempted = try container.decodeIfPresent(Bool.self, forKey: .attempted)
		self.autoAdvance = try container.decodeIfPresent(Bool.self, forKey: .autoAdvance)
		self.billing = try container.decodeIfPresent(String.self, forKey: .billing)
		self.billingReason = try container.decodeIfPresent(StripeBillingReason.self, forKey: .billingReason)
		self.charge = try container.decodeIfPresent(String.self, forKey: .charge)
		self.closed = try container.decodeIfPresent(Bool.self, forKey: .closed)
		self.currency = try container.decodeIfPresent(StripeCurrency.self, forKey: .currency)
		self.customer = try container.decodeIfPresent(String.self, forKey: .customer)
		self.created = try container.decodeIfPresent(Date.self, forKey: .created)
		self.defaultSource = try container.decodeIfPresent(String.self, forKey: .defaultSource)
		self.description = try container.decodeIfPresent(String.self, forKey: .description)
		self.discount = try container.decodeIfPresent(StripeDiscount.self, forKey: .discount)
		self.dueDate = try container.decodeIfPresent(Date.self, forKey: .dueDate)
		self.endingBalance = try container.decodeIfPresent(Int.self, forKey: .endingBalance)
		self.forgiven = try container.decodeIfPresent(Bool.self, forKey: .forgiven)
		self.hostedInvoiceUrl = try container.decodeIfPresent(String.self, forKey: .hostedInvoiceUrl)
		self.invoicePdf = try container.decodeIfPresent(String.self, forKey: .invoicePdf)
		self.lines = try container.decodeIfPresent(InvoiceLineGroup.self, forKey: .lines)
		self.livemode = try container.decodeIfPresent(Bool.self, forKey: .livemode)
		self.metadata = try container.decode([String: String].self, forKey: .metadata)
		self.nextPaymentAttempt = try container.decodeIfPresent(Date.self, forKey: .nextPaymentAttempt)
		self.number = try container.decodeIfPresent(String.self, forKey: .number)
		self.paid = try container.decodeIfPresent(Bool.self, forKey: .paid)

		if let paymentIntentId = try? container.decodeIfPresent(String.self, forKey: .paymentIntent) {
			self.paymentIntentId = paymentIntentId
			self.paymentIntent = nil
		}

		if let paymentIntent = try? container.decodeIfPresent(StripePaymentIntent.self, forKey: .paymentIntent) {
			self.paymentIntent = paymentIntent
			self.paymentIntentId = paymentIntent?.id
		}

		self.periodEnd = try container.decodeIfPresent(Date.self, forKey: .periodEnd)
		self.periodStart = try container.decodeIfPresent(Date.self, forKey: .periodStart)
		self.receiptNumber = try container.decodeIfPresent(String.self, forKey: .receiptNumber)
		self.startingBalance = try container.decodeIfPresent(Int.self, forKey: .startingBalance)
		self.statementDescriptor = try container.decodeIfPresent(String.self, forKey: .statementDescriptor)
		self.status = try container.decodeIfPresent(StripeInvoiceStatus.self, forKey: .status)
		self.statusTransitions = try container.decodeIfPresent(StripeInvoiceStatusTransitions.self, forKey: .statusTransitions)
		self.subscription = try container.decodeIfPresent(String.self, forKey: .subscription)
		self.subscriptionProrationDate = try container.decodeIfPresent(Int.self, forKey: .subscriptionProrationDate)
		self.subtotal = try container.decodeIfPresent(Int.self, forKey: .subtotal)
		self.total = try container.decodeIfPresent(Int.self, forKey: .total)
		self.tax = try container.decodeIfPresent(Int.self, forKey: .tax)
		self.taxPercent = try container.decodeIfPresent(Decimal.self, forKey: .taxPercent)
		self.webhooksDeliveredAt = try container.decodeIfPresent(Date.self, forKey: .webhooksDeliveredAt)
	}
}
