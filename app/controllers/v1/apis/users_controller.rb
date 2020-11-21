class V1::Apis::UsersController < ApplicationController
  def index
    render json: {
      users: [
        {
          id: 1,
          name: 'Ali',
          age: 22
        },
        {
          id: 2,
          name: 'Mohammed',
          age: 30
        }
      ]
    }.to_json
  end
end
