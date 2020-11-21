module V1::Auth
  class SessionsController < ApplicationController
    # GET /v1/signin
    def signin
      render :create
    end
  end
end
