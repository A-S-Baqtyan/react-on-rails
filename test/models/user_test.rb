# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  address         :string           not null
#  email           :string
#  first_name      :string           not null
#  last_name       :string           not null
#  mobile          :string
#  password_digest :string           not null
#  role            :integer          default("user"), not null
#  status          :integer          default("pending"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email            (email) UNIQUE
#  index_users_on_mobile           (mobile) UNIQUE
#  index_users_on_password_digest  (password_digest) UNIQUE
#  index_users_on_status_and_role  (status,role)
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
