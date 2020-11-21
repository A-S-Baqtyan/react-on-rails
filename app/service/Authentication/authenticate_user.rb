module Authentication
  class AuthenticateUser < Base
    attr_accessor :errors

    def call
      process
    end

    private

      attr_reader :token

      def process
        verified_user
        self
      end

      def token_decoded?
        Authentication::
          JsonWebToken.
          decode(token)
      end

      def verified_user
        self.errors = \
          if invalid_token?
            error('invalid_token')
          elsif user.nil?
            error('user_not_exsists')
          elsif user.inactive?
            error('inactive_account')
          end
      end

      def invalid_token?
        token.blank? || !token_decoded?
      end

      def user
        @user ||= User.find_by_id(token_decoded?[:id])
      end
  end
end