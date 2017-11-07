class ReceiptMailer < ApplicationMailer

  def order_receipt_email(user)
    @order = order
    mail(to: @order.email, subject: "Your Receipt for Order ##{@order.id}")
  end
end
