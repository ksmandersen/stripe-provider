//
//  Subscription.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import Foundation

/**
 Subscription object
 https://stripe.com/docs/api/curl#subscription_object
 */

public struct StripeSubscription: StripeModel {
    public var id: String
    public var object: String
    public var applicationFeePercent: Decimal?
    public var billing: String?
    public var billingCycleAnchor: Date?
    public var cancelAtPeriodEnd: Bool?
    public var canceledAt: Date?
    public var created: Date?
    public var currentPeriodEnd: Date?
    public var currentPeriodStart: Date?
    public var customer: String?
    public var daysUntilDue: Int?
    public var discount: StripeDiscount?
    public var endedAt: Date?
    public var items: SubscriptionItemsList?
	public var latestInvoice: StripeInvoice?
	public var latestInvoiceId: String?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var plan: StripePlan?
    public var quantity: Int?
    public var start: Date?
    public var status: StripeSubscriptionStatus?
    public var taxPercent: Decimal?
    public var trialEnd: Date?
    public var trialStart: Date?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case applicationFeePercent = "application_fee_percent"
        case billing
        case billingCycleAnchor = "billing_cycle_anchor"
        case cancelAtPeriodEnd = "cancel_at_period_end"
        case canceledAt = "canceled_at"
        case created
        case currentPeriodEnd = "current_period_end"
        case currentPeriodStart = "current_period_start"
        case customer
        case daysUntilDue = "days_until_due"
        case discount
        case endedAt = "ended_at"
        case items
		case latestInvoice = "latest_invoice"
        case livemode
        case metadata
        case plan
        case quantity
        case start
        case status
        case taxPercent = "tax_percent"
        case trialEnd = "trial_end"
        case trialStart = "trial_start"
    }

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.id = try container.decode(String.self, forKey: .id)
		self.object = try container.decode(String.self, forKey: .object)
		self.applicationFeePercent = try container.decodeIfPresent(Decimal.self, forKey: .applicationFeePercent)
		self.billing = try container.decodeIfPresent(String.self, forKey: .billing)
		self.billingCycleAnchor = try container.decodeIfPresent(Date.self, forKey: .billingCycleAnchor)
		self.cancelAtPeriodEnd = try container.decodeIfPresent(Bool.self, forKey: .cancelAtPeriodEnd)
		self.canceledAt = try container.decodeIfPresent(Date.self, forKey: .canceledAt)
		self.created = try container.decodeIfPresent(Date.self, forKey: .created)
		self.currentPeriodEnd = try container.decodeIfPresent(Date.self, forKey: .currentPeriodEnd)
		self.currentPeriodStart = try container.decodeIfPresent(Date.self, forKey: .currentPeriodStart)
		self.customer = try container.decodeIfPresent(String.self, forKey: .customer)
		self.daysUntilDue = try container.decodeIfPresent(Int.self, forKey: .daysUntilDue)
		self.discount = try container.decodeIfPresent(StripeDiscount.self, forKey: .discount)
		self.endedAt = try container.decodeIfPresent(Date.self, forKey: .endedAt)
		self.items = try container.decodeIfPresent(SubscriptionItemsList.self, forKey: .items)

		if let latestInvoice = try? container.decodeIfPresent(StripeInvoice.self, forKey: .latestInvoice) {
			self.latestInvoice = latestInvoice
			self.latestInvoiceId = latestInvoice?.id
		}

		if let latestInvoiceId = try? container.decodeIfPresent(String.self, forKey: .latestInvoice) {
			self.latestInvoiceId = latestInvoiceId
			self.latestInvoice = nil
		}

		self.livemode = try container.decodeIfPresent(Bool.self, forKey: .livemode)
		self.metadata = try container.decode([String: String].self, forKey: .metadata)
		self.plan = try container.decodeIfPresent(StripePlan.self, forKey: .plan)
		self.quantity = try container.decodeIfPresent(Int.self, forKey: .quantity)
		self.start = try container.decodeIfPresent(Date.self, forKey: .start)
		self.status = try container.decodeIfPresent(StripeSubscriptionStatus.self, forKey: .status)
		self.taxPercent = try container.decodeIfPresent(Decimal.self, forKey: .taxPercent)
		self.trialEnd = try container.decodeIfPresent(Date.self, forKey: .trialEnd)
		self.trialStart = try container.decodeIfPresent(Date.self, forKey: .trialStart)

	}
}
