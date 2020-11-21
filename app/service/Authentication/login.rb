module Authentication
  class Login < Base
    attr_accessor :credentials

    def self.respons(**args)
      new(args).call
    end

    def call
      process
      self
    end

    private

      attr_reader :login, :password

      def process
        validate_login

        return unless success?
        activate_user
        set_credentials
      end

      def invalid_login?
        user.nil?
      end

      def invalid_password?
        !user.authenticate(password)
      end

      def user
        @user ||= User.where('email = ? OR mobile = ?', login, login).first
      end

      def validate_login
        self.errors = \
          if login.blank?
            error('email_or_mobile_cannot_be_blank')
          elsif password.blank?
            error('password_cannot_be_blank')
          elsif invalid_login?
            error('invalid_email_or_mobile')
          elsif invalid_password?
            error('invalid_password')
          elsif user.inactive?
            error('inactive_account')
          end
      end

      def activate_user
        if user.try(:pending?)
          user.active!
        end
      end

      def set_credentials
        self.credentials = {
          user: user,
          token: user.token
        }
      end
  end
end