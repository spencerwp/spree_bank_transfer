module Spree
  module PaymentDecorator
    def self.prepended(base)
      base.attr_accessor :validate_bank_details

      base.has_one_attached :receipt
      base.belongs_to :order
      base.validates :bank_name, :deposited_on, :receipt, presence: true, if: :validate_bank_details

      base.before_save :update_source_type, if: :validate_bank_details
      base.after_save :update_order_state, if: :validate_bank_details

      base.scope :from_bank_transfer, -> { joins(:payment_method).where(spree_payment_methods: { type: 'Spree::PaymentMethod::BankTransfer' }) }

      base.whitelisted_ransackable_attributes = %w( bank_name state )
    end

    def details_submitted?
      bank_name?
    end

    private

    def update_source_type
      self.source_type = "Spree::PaymentMethod::BankTransfer"
    end

    def update_order_state
      order.update(payment_state: :paid)
    end
  end
end

::Spree::Payment.prepend(Spree::PaymentDecorator)
