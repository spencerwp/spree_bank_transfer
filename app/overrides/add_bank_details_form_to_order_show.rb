Deface::Override.new(
  virtual_path: 'spree/orders/show',
  name: 'add_bank_details_form_to_order_show',
  insert_bottom: "[data-hook='order-payment']",
  partial: "spree/orders/bank_transfer_form"
)
