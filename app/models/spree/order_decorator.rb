module Spree
  module OrderDecorator
    def self.prepended(base)
      base.whitelisted_ransackable_associations += %w(payments)
    end
  end
end

::Spree::Order.prepend(Spree::OrderDecorator)
