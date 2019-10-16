//
//  StripeEvent.swift
//  Stripe
//
//  Created by Kristian Andersen on 11/10/2019.
//

import Foundation

public struct StripeEvent: StripeModel {
	/// Unique identifier for the object.
	public let id: String
	/// String representing the object’s type. Objects of the same type share the same value.
	public let object: String
	/// Description of the event (e.g., `invoice.created` or `charge.refunded`).
	public let type: StripeEventType
	/// The Stripe API version used to render data. Note: This property is populated only for events on or after October 31, 2014.
	public let apiVersion: String?
	/// Time at which the object was created. Measured in seconds since the Unix epoch.
	public let created: Date?
	/// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
	public let livemode: Bool?
	/// Number of webhooks that have yet to be successfully delivered (i.e., to return a 20x response) to the URLs you’ve specified.
	public let pendingWebhooks: Int?

	/// Object containing data associated with the event.
	public var data: StripeEventData?

	public enum CodingKeys: String, CodingKey {
		case id
		case object
		case type
		case apiVersion = "api_version"
		case created
		case livemode
		case pendingWebhooks = "pending_webhooks"
		case data
	}
}

public enum StripeEventType: String, StripeModel {
	/// Occurs whenever an account status or property has changed.
	/// describes an account
	case accountUpdated = "account.updated"
	/// Occurs whenever a user authorizes an application. Sent to the related application only.
	/// describes an "application"
	case accountApplicationAuthorized = "account.application.authorized"
	/// Occurs whenever a user deauthorizes an application. Sent to the related application only.
	/// describes an "application"
	case accountApplicationDeauthorized = "account.application.deauthorized"
	/// Occurs whenever an external account is created.
	/// describes an external account (e.g., card or bank a
	case accountExternalAccountCreated = "account.external_account.created"
	/// Occurs whenever an external account is deleted.
	/// describes an external account (e.g., card or bank a
	case accountExternalAccountDeleted = "account.external_account.deleted"
	/// Occurs whenever an external account is updated.
	/// describes an external account (e.g., card or bank a
	case accountExternalAccountUpdated = "account.external_account.updated"
	/// Occurs whenever an application fee is created on a charge.
	/// describes an application fee
	case applicationFeeCreated = "application_fee.created"
	/// Occurs whenever an application fee is refunded, whether from refunding a charge or from refunding the application fee directly. This includes partial refunds.
	/// describes an application fee
	case applicationFeeRefunded = "application_fee.refunded"
	/// Occurs whenever an application fee refund is updated.
	/// describes a fee refund
	case applicationFeeRefundUpdated = "application_fee.refund.updated"
	/// Occurs whenever your Stripe balance has been updated (e.g., when a charge is available to be paid out). By default, Stripe automatically transfers funds in your balance to your bank account on a daily basis.
	/// describes a balance
	case balanceAvailable = "balance.available"
	/// Occurs whenever a capability has new requirements or a new status.
	/// describes a capability
	case capabilityUpdated = "capability.updated"
	/// Occurs whenever a previously uncaptured charge is captured.
	/// describes a charge
	case chargeCaptured = "charge.captured"
	/// Occurs whenever an uncaptured charge expires.
	/// describes a charge
	case chargeExpired = "charge.expired"
	/// Occurs whenever a failed charge attempt occurs.
	/// describes a charge
	case chargeFailed = "charge.failed"
	/// Occurs whenever a pending charge is created.
	/// describes a charge
	case chargePending = "charge.pending"
	/// Occurs whenever a charge is refunded, including partial refunds.
	/// describes a charge
	case chargeRefunded = "charge.refunded"
	/// Occurs whenever a new charge is created and is successful.
	/// describes a charge
	case chargeSucceeded = "charge.succeeded"
	/// Occurs whenever a charge description or metadata is updated.
	/// describes a charge
	case chargeUpdated = "charge.updated"
	/// Occurs when a dispute is closed and the dispute status changes to lost, warning_closed, or won.
	/// describes a dispute
	case chargeDisputeClosed = "charge.dispute.closed"
	/// Occurs whenever a customer disputes a charge with their bank.
	/// describes a dispute
	case chargeDisputeCreated = "charge.dispute.created"
	/// Occurs when funds are reinstated to your account after a dispute is closed. This includes partially refunded payments.
	/// describes a dispute
	case chargeDisputeFundsReinstated = "charge.dispute.funds_reinstated"
	/// Occurs when funds are removed from your account due to a dispute.
	/// describes a dispute
	case chargeDisputeFundsWithdrawn = "charge.dispute.funds_withdrawn"
	/// Occurs when the dispute is updated (usually with evidence).
	/// describes a dispute
	case chargeDisputeUpdated = "charge.dispute.updated"
	/// Occurs whenever a refund is updated, on selected payment methods.
	/// describes a refund
	case chargeRefundUpdated = "charge.refund.updated"
	/// Occurs when a Checkout Session has been successfully completed.
	/// describes a checkout session
	case checkoutSessionCompleted = "checkout.session.completed"
	/// Occurs whenever a coupon is created.
	/// describes a coupon
	case couponCreated = "coupon.created"
	/// Occurs whenever a coupon is deleted.
	/// describes a coupon
	case couponDeleted = "coupon.deleted"
	/// Occurs whenever a coupon is updated.
	/// describes a coupon
	case couponUpdated = "coupon.updated"
	/// Occurs whenever a credit note is created.
	/// describes a credit note
	case creditNoteCreated = "credit_note.created"
	/// Occurs whenever a credit note is updated.
	/// describes a credit note
	case creditNoteUpdated = "credit_note.updated"
	/// Occurs whenever a credit note is voided.
	/// describes a credit note
	case creditNoteVoided = "credit_note.voided"
	/// Occurs whenever a new customer is created.
	/// describes a customer
	case customerCreated = "customer.created"
	/// Occurs whenever a customer is deleted.
	/// describes a customer
	case customerDeleted = "customer.deleted"
	/// Occurs whenever any property of a customer changes.
	/// describes a customer
	case customerUpdated = "customer.updated"
	/// Occurs whenever a coupon is attached to a customer.
	/// describes a discount
	case customerDiscountCreated = "customer.discount.created"
	/// Occurs whenever a coupon is removed from a customer.
	/// describes a discount
	case customerDiscountDeleted = "customer.discount.deleted"
	/// Occurs whenever a customer is switched from one coupon to another.
	/// describes a discount
	case customerDiscountUpdated = "customer.discount.updated"
	/// Occurs whenever a new source is created for a customer.
	/// describes a source (e.g., card)
	case customerSourceCreated = "customer.source.created"
	/// Occurs whenever a source is removed from a customer.
	/// describes a source (e.g., card)
	case customerSourceDeleted = "customer.source.deleted"
	/// Occurs whenever a card or source will expire at the end of the month.
	/// describes a source (e.g., card)
	case customerSourceExpiring = "customer.source.expiring"
	/// Occurs whenever a source's details are changed.
	/// describes a source (e.g., card)
	case customerSourceUpdated = "customer.source.updated"
	/// Occurs whenever a customer is signed up for a new plan.
	/// describes a subscription
	case customerSubscriptionCreated = "customer.subscription.created"
	/// Occurs whenever a customer's subscription ends.
	/// describes a subscription
	case customerSubscriptionDeleted = "customer.subscription.deleted"
	/// Occurs three days before a subscription's trial period is scheduled to end, or when a trial is ended immediately (using trial_end=now).
	/// describes a subscription
	case customerSubscriptionTrialWillEnd = "customer.subscription.trial_will_end"
	/// Occurs whenever a subscription changes (e.g., switching from one plan to another, or changing the status from trial to active).
	/// describes a subscription
	case customerSubscriptionUpdated = "customer.subscription.updated"
	/// Occurs whenever a tax ID is created for a customer.
	/// describes a tax id
	case customerTaxIdCreated = "customer.tax_id.created"
	/// Occurs whenever a tax ID is deleted from a customer.
	/// describes a tax id
	case customerTaxIdDeleted = "customer.tax_id.deleted"
	/// Occurs whenever a customer's tax ID is updated.
	/// describes a tax id
	case customerTaxIdUpdated = "customer.tax_id.updated"
	/// Occurs whenever a new Stripe-generated file is available for your account.
	/// describes a file
	case fileCreated = "file.created"
	/// Occurs whenever a new invoice is created. To learn how webhooks can be used with this event, and how they can affect it, see Using Webhooks with Subscriptions.
	/// describes an invoice
	case invoiceCreated = "invoice.created"
	/// Occurs whenever a draft invoice is deleted.
	/// describes an invoice
	case invoiceDeleted = "invoice.deleted"
	/// Occurs whenever a draft invoice is finalized and updated to be an open invoice.
	/// describes an invoice
	case invoiceFinalized = "invoice.finalized"
	/// Occurs whenever an invoice is marked uncollectible.
	/// describes an invoice
	case invoiceMarkedUncollectible = "invoice.marked_uncollectible"
	/// Occurs whenever an invoice payment attempt requires further user action to complete.
	/// describes an invoice
	case invoicePaymentActionRequired = "invoice.payment_action_required"
	/// Occurs whenever an invoice payment attempt fails, due either to a declined payment or to the lack of a stored payment method.
	/// describes an invoice
	case invoicePaymentFailed = "invoice.payment_failed"
	/// Occurs whenever an invoice payment attempt succeeds.
	/// describes an invoice
	case invoicePaymentSucceeded = "invoice.payment_succeeded"
	/// Occurs whenever an invoice email is sent out.
	/// describes an invoice
	case invoiceSent = "invoice.sent"
	/// Occurs X number of days before a subscription is scheduled to create an invoice that is automatically charged—where X is determined by your subscriptions settings. Note: The received Invoice object will not have an invoice ID.
	/// describes an invoice
	case invoiceUpcoming = "invoice.upcoming"
	/// Occurs whenever an invoice changes (e.g., the invoice amount).
	/// describes an invoice
	case invoiceUpdated = "invoice.updated"
	/// Occurs whenever an invoice is voided.
	/// describes an invoice
	case invoiceVoided = "invoice.voided"
	/// Occurs whenever an invoice item is created.
	/// describes an invoiceitem
	case invoiceitemCreated = "invoiceitem.created"
	/// Occurs whenever an invoice item is deleted.
	/// describes an invoiceitem
	case invoiceitemDeleted = "invoiceitem.deleted"
	/// Occurs whenever an invoice item is updated.
	/// describes an invoiceitem
	case invoiceitemUpdated = "invoiceitem.updated"
	/// Occurs whenever an authorization is created.
	/// describes an issuing authorization
	case issuingAuthorizationCreated = "issuing_authorization.created"
	/// Represents a synchronous request for authorization, see Using your integration to handle authorization requests.
	/// describes an issuing authorization
	case issuingAuthorizationRequest = "issuing_authorization.request"
	/// Occurs whenever an authorization is updated.
	/// describes an issuing authorization
	case issuingAuthorizationUpdated = "issuing_authorization.updated"
	/// Occurs whenever a card is created.
	/// describes an issuing card
	case issuingCardCreated = "issuing_card.created"
	/// Occurs whenever a card is updated.
	/// describes an issuing card
	case issuingCardUpdated = "issuing_card.updated"
	/// Occurs whenever a cardholder is created.
	/// describes an issuing cardholder
	case issuingCardholderCreated = "issuing_cardholder.created"
	/// Occurs whenever a cardholder is updated.
	/// describes an issuing cardholder
	case issuingCardholderUpdated = "issuing_cardholder.updated"
	/// Occurs whenever a dispute is created.
	/// describes an issuing dispute
	case issuingDisputeCreated = "issuing_dispute.created"
	/// Occurs whenever a dispute is updated.
	/// describes an issuing dispute
	case issuingDisputeUpdated = "issuing_dispute.updated"
	/// Occurs whenever an issuing settlement is created.
	/// describes an issuing settlement
	case issuingSettlementCreated = "issuing_settlement.created"
	/// Occurs whenever an issuing settlement is updated.
	/// describes an issuing settlement
	case issuingSettlementUpdated = "issuing_settlement.updated"
	/// Occurs whenever an issuing transaction is created.
	/// describes an issuing transaction
	case issuingTransactionCreated = "issuing_transaction.created"
	/// Occurs whenever an issuing transaction is updated.
	/// describes an issuing transaction
	case issuingTransactionUpdated = "issuing_transaction.updated"
	/// Occurs whenever an order is created.
	/// describes an order
	case orderCreated = "order.created"
	/// Occurs whenever an order payment attempt fails.
	/// describes an order
	case orderPaymentFailed = "order.payment_failed"
	/// Occurs whenever an order payment attempt succeeds.
	/// describes an order
	case orderPaymentSucceeded = "order.payment_succeeded"
	/// Occurs whenever an order is updated.
	/// describes an order
	case orderUpdated = "order.updated"
	/// Occurs whenever an order return is created.
	/// describes an order return
	case orderReturnCreated = "order_return.created"
	/// Occurs when a PaymentIntent has funds to be captured. Check the amount_capturable property on the PaymentIntent to determine the amount that can be captured. You may capture the PaymentIntent with an amount_to_capture value up to the specified amount. Learn more about capturing PaymentIntents.
	/// describes a payment intent
	case paymentIntentAmountCapturableUpdated = "payment_intent.amount_capturable_updated"
	/// Occurs when a new PaymentIntent is created.
	/// describes a payment intent
	case paymentIntentCreated = "payment_intent.created"
	/// Occurs when a PaymentIntent has failed the attempt to create a source or a payment.
	/// describes a payment intent
	case paymentIntentPaymentFailed = "payment_intent.payment_failed"
	/// Occurs when a PaymentIntent has been successfully fulfilled.
	/// describes a payment intent
	case paymentIntentSucceeded = "payment_intent.succeeded"
	/// Occurs whenever a new payment method is attached to a customer.
	/// describes a payment method
	case paymentMethodAttached = "payment_method.attached"
	/// Occurs whenever a card payment method's details are automatically updated by the network.
	/// describes a payment method
	case paymentMethodCardAutomaticallyUpdated = "payment_method.card_automatically_updated"
	/// Occurs whenever a payment method is detached from a customer.
	/// describes a payment method
	case paymentMethodDetached = "payment_method.detached"
	/// Occurs whenever a payment method is updated via the PaymentMethod update API.
	/// describes a payment method
	case paymentMethodUpdated = "payment_method.updated"
	/// Occurs whenever a payout is canceled.
	/// describes a payout
	case payoutCanceled = "payout.canceled"
	/// Occurs whenever a payout is created.
	/// describes a payout
	case payoutCreated = "payout.created"
	/// Occurs whenever a payout attempt fails.
	/// describes a payout
	case payoutFailed = "payout.failed"
	/// Occurs whenever a payout is expected to be available in the destination account. If the payout fails, a payout.failed notification is also sent, at a later time.
	/// describes a payout
	case payoutPaid = "payout.paid"
	/// Occurs whenever a payout's metadata is updated.
	/// describes a payout
	case payoutUpdated = "payout.updated"
	/// Occurs whenever a person associated with an account is created.
	/// describes a person
	case personCreated = "person.created"
	/// Occurs whenever a person associated with an account is deleted.
	/// describes a person
	case personDeleted = "person.deleted"
	/// Occurs whenever a person associated with an account is updated.
	/// describes a person
	case personUpdated = "person.updated"
	/// Occurs whenever a plan is created.
	/// describes a plan
	case planCreated = "plan.created"
	/// Occurs whenever a plan is deleted.
	/// describes a plan
	case planDeleted = "plan.deleted"
	/// Occurs whenever a plan is updated.
	/// describes a plan
	case planUpdated = "plan.updated"
	/// Occurs whenever a product is created.
	/// describes a product
	case productCreated = "product.created"
	/// Occurs whenever a product is deleted.
	/// describes a product
	case productDeleted = "product.deleted"
	/// Occurs whenever a product is updated.
	/// describes a product
	case productUpdated = "product.updated"
	/// Occurs whenever an early fraud warning is created.
	/// describes an early fraud warning
	case radarEarlyFraudWarningCreated = "radar.early_fraud_warning.created"
	/// Occurs whenever an early fraud warning is updated.
	/// describes an early fraud warning
	case radarEarlyFraudWarningUpdated = "radar.early_fraud_warning.updated"
	/// Occurs whenever a recipient is created.
	/// describes a recipient
	case recipientCreated = "recipient.created"
	/// Occurs whenever a recipient is deleted.
	/// describes a recipient
	case recipientDeleted = "recipient.deleted"
	/// Occurs whenever a recipient is updated.
	/// describes a recipient
	case recipientUpdated = "recipient.updated"
	/// Occurs whenever a requested **ReportRun** failed to complete.
	/// describes a report run
	case reportingReportRunFailed = "reporting.report_run.failed"
	/// Occurs whenever a requested **ReportRun** completed succesfully.
	/// describes a report run
	case reportingReportRunSucceeded = "reporting.report_run.succeeded"
	/// Occurs whenever a **ReportType** is updated (typically to indicate that a new day's data has come available).
	/// describes a report type
	case reportingReportTypeUpdated = "reporting.report_type.updated"
	/// Occurs whenever a review is closed. The review's reason field indicates why: approved, disputed, refunded, or refunded_as_fraud.
	/// describes a review
	case reviewClosed = "review.closed"
	/// Occurs whenever a review is opened.
	/// describes a review
	case reviewOpened = "review.opened"
	/// Occurs when a new SetupIntent is created.
	/// describes a setup intent
	case setupIntentCreated = "setup_intent.created"
	/// Occurs when a SetupIntent has failed the attempt to setup a payment method.
	/// describes a setup intent
	case setupIntentSetupFailed = "setup_intent.setup_failed"
	/// Occurs when an SetupIntent has successfully setup a payment method.
	/// describes a setup intent
	case setupIntentSucceeded = "setup_intent.succeeded"
	/// Occurs whenever a Sigma scheduled query run finishes.
	/// describes a scheduled query run
	case sigmaScheduledQueryRunCreated = "sigma.scheduled_query_run.created"
	/// Occurs whenever a SKU is created.
	/// describes a sku
	case skuCreated = "sku.created"
	/// Occurs whenever a SKU is deleted.
	/// describes a sku
	case skuDeleted = "sku.deleted"
	/// Occurs whenever a SKU is updated.
	/// describes a sku
	case skuUpdated = "sku.updated"
	/// Occurs whenever a source is canceled.
	/// describes a source (e.g., card)
	case sourceCanceled = "source.canceled"
	/// Occurs whenever a source transitions to chargeable.
	/// describes a source (e.g., card)
	case sourceChargeable = "source.chargeable"
	/// Occurs whenever a source fails.
	/// describes a source (e.g., card)
	case sourceFailed = "source.failed"
	/// Occurs whenever a source mandate notification method is set to manual.
	/// describes a source (e.g., card)
	case sourceMandateNotification = "source.mandate_notification"
	/// Occurs whenever the refund attributes are required on a receiver source to process a refund or a mispayment.
	/// describes a source (e.g., card)
	case sourceRefundAttributesRequired = "source.refund_attributes_required"
	/// Occurs whenever a source transaction is created.
	/// describes a source transaction
	case sourceTransactionCreated = "source.transaction.created"
	/// Occurs whenever a source transaction is updated.
	/// describes a source transaction
	case sourceTransactionUpdated = "source.transaction.updated"
	/// Occurs whenever a new tax rate is created.
	/// describes a tax rate
	case taxRateCreated = "tax_rate.created"
	/// Occurs whenever a tax rate is updated.
	/// describes a tax rate
	case taxRateUpdated = "tax_rate.updated"
	/// Occurs whenever a top-up is canceled.
	/// describes a topup
	case topupCanceled = "topup.canceled"
	/// Occurs whenever a top-up is created.
	/// describes a topup
	case topupCreated = "topup.created"
	/// Occurs whenever a top-up fails.
	/// describes a topup
	case topupFailed = "topup.failed"
	/// Occurs whenever a top-up is reversed.
	/// describes a topup
	case topupReversed = "topup.reversed"
	/// Occurs whenever a top-up succeeds.
	/// describes a topup
	case topupSucceeded = "topup.succeeded"
	/// Occurs whenever a transfer is created.
	/// describes a transfer
	case transferCreated = "transfer.created"
	/// Occurs whenever a transfer failed.
	/// describes a transfer
	case transferFailed = "transfer.failed"
	/// Occurs after a transfer is paid. For Instant Payouts, the event will be sent on the next business day, although the funds should be received well beforehand.
	/// describes a transfer
	case transferPaid = "transfer.paid"
	/// Occurs whenever a transfer is reversed, including partial reversals.
	/// describes a transfer
	case transferReversed = "transfer.reversed"
	/// Occurs whenever a transfer's description or metadata is updated.
	/// describes a transfer
	case transferUpdated = "transfer.updated"
	/// An event not supported by the event type
	case unknownEvent = "unknown"
}

public enum StripeEventObject: StripeModel {
	case charge(StripeCharge)
	case customer(StripeCustomer)
	case invoice(StripeInvoice)
	case paymentIntent(PaymentIntent)
	case subscription(StripeSubscription)
	case invalid

	public init(from decoder: Decoder) throws {
		if let customer = try? StripeCustomer(from: decoder) {
			self = .customer(customer)
		} else if let invoice = try? StripeInvoice(from: decoder) {
			self = .invoice(invoice)
		} else {
			self = .invalid
		}
	}

	public func encode(to encoder: Encoder) throws {
		switch self {
		case let .charge(charge): try charge.encode(to: encoder)
		case let .customer(customer): try customer.encode(to: encoder)
		case let .invoice(invoice): try invoice.encode(to: encoder)
		case let .paymentIntent(paymentIntent): try paymentIntent.encode(to: encoder)
		case let .subscription(subscription): try subscription.encode(to: encoder)
		default: break
		}
	}
}

public struct StripeEventData: StripeModel {
	public let previousAttributes: [String: JSON]
	public let object: StripeEventObject?

	public enum CodingKeys: String, CodingKey {
		case previousAttributes = "previous_attributes"
		case object
	}
}
