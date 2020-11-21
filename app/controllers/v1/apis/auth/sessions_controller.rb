module V1::Apis::Auth
  class SessionsController < V1::ApiController
    # POST /v1/apis/auth/sessions
    def create
      login = Authentication::Login.respons(login_params)

      if login.success?
        data = {
          user: login.credentials.dig(:user).as_api_response(:show),
          token: login.credentials.dig(:token)
        }
        render_success(
          message: I18n.t('Login_successfully'), 
          data: data
        )
      else
        render_bad_request(error: 1110)
      end
    end

    # def destroy
    # end

    private

    def login_params
      {
        login: params[:login],
        password: params[:password]
      }
    end
  end
end
