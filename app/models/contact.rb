class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :comments
  attribute :phone
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        subject: 'Rhemaholic Feedback',
        to: 'timiderinola@gmail.com',
        from: %("#{name}" <#{email}>)
    }
  end
end