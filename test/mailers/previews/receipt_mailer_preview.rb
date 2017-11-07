class ReceiptMailerPreview < ActionMailer::Preview
  def order_receipt_email
    ReceiptMailer.order_receipt_email(Order.first)
  end
end
