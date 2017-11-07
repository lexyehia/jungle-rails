class ReceiptMailer < ApplicationMailer

  def order_receipt_email(order)
    @order = order
    mail(to: @order.email, subject: "Your Receipt for Order ##{@order.id}")
  end
end
