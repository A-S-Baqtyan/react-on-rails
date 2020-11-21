class V1::ApiController < ApplicationController
  include JsonResponders
  include ExceptionHandler
  include MissingData
  include Consul::Controller

  before_action :set_locale
  # before_action :validate_token!
  # require_power_check

  private

  # Set Power and inject it with current user
  current_power do
    Power.new(@current_user)
  end

  # Authenticate the request by headers (used for all apis)
  # def validate_token!
  #   return if missing_headers!('Authorization')

  #   @token ||= AuthenticateUser.get(request.headers['Authorization'])
  #   set_curret_user_with_access
  # end

  # Set request locale
  def set_locale
    I18n.locale = params[:locale] || request.headers['locale'] || I18n.default_locale
  end

  # Set Current User and vairables
  # def set_curret_user_with_access
  #   @current_user = @token[:user]
  #   @orgnaization_id = @token[:orgnaization_id]
  #   @current_orgnaization = Orgnaization.find_by(slug: @token[:slug])
  # end
end
