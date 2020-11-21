module Authentication
  class SendResetPasswordEmail < Base
    def call
      process
      self
    end
    private

    attr_reader :login

    def process
      return unless production?
      validate
      return unless success?
      send_reset_password_link
    end

    def validate
      self.errors = \
        if login.blank?
          error('email_or_mobile_cannot_be_blank')
        elsif user.nil?
          error('invalid_email_or_mobile')
        elsif user.inactive?
          error('inactive_account')
        end
    end

    def send_reset_password_link
      if mobile_number?
        # TODO call send mobile service
      else
        send_password_link_by_email
      end
    end

    def send_password_link_by_email
      PasswordMailer.with(user: user).send_password.deliver_later
    end

    def user
      @user ||= \
        User.find_by(login_type => login)
    end

    def login_type
      mobile_number? ? :mobile : :email
    end

    def mobile_number?
      return true if Integer(login)
    rescue
      false
    end

    def production?
      Rails.env == 'production'
    end
  end
end