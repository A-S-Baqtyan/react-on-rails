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
class User < ApplicationRecord
  ## -------------------- Requirements -------------------- ##
  include UserPresenter
  has_secure_password(validations: false)
  ## ----------------------- Scopes ----------------------- ##
  ## --------------------- Constants ---------------------- ##
  ## ----------------------- Enums ------------------------ ##
  enum role: { user: 0, customr: 1, admin:2  }
  enum status: { pending: 0, active: 1, inactive: 2 }
  ## -------------------- Associations -------------------- ##
  ## -------------------- Validations --------------------- ##
  validates :first_name, :last_name, :address, presence: true
  validates :email,
            presence: true, if: -> { mobile.nil? } ,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :mobile,
            presence: true, if: -> { email.nil? } ,
            uniqueness: true,
            numericality: { only_integer: true },
            length:       { is: 9 },
            format:       { with: /[7]\d{8}/ }
  validates :role,
            presence: true,
            inclusion: { in: self.roles }
  validates :status,
            presence: true,
            inclusion: { in: self.statuses }
  ## --------------------- Callbacks ---------------------- ##
  ## ------------------- Class Methods -------------------- ##
  ## ---------------------- Methods ----------------------- ##

  def token
    Authentication::JsonWebToken.encode(payload)
  end

  private

  def payload
    {
      id: id,
      role: role,
      email: email,
      mobile: mobile,
      status: status,
      last_name: last_name,
      first_name: first_name
    }
  end
end
