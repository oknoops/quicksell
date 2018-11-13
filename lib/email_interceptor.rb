class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = [ 'no-reply@qck.sale' ]
  end
end
