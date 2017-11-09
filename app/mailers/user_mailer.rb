class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_email(order)
    @order = order
    @line_items = @order.line_items
    mail(to: @order.email, subject: "Order ID: #{@order.id.to_s}")
  end
end
