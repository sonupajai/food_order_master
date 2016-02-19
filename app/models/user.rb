class User
  include Mongoid::Document
  include Mongoid::Paperclip

  ROLES = %i[admin owner normal_user]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_mongoid_attached_file :image
  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :user_type,          type: String, default: ""
  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String
  field :role,               type: String
  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  has_many :hotels

  before_create :set_default_role

  has_many :orders

  after_create :sending_welcome_email

  def sending_welcome_email
    UserNotifier.welcome_email(self).deliver
  end

  def set_default_role
    self.role = "normal_user" if self.role.blank?
  end

  ROLES.each do |r_name|
    define_method("#{r_name}?") do
      self.role == "#{r_name}"
    end
  end

  # because of metaprogramming below 3 methods became simple above code
  # def admin?
  #   self.role == "admin"
  # end

  # def owner?
  #   self.role == "owner"
  # end

  # def normal_user?
  #   self.role == "normal_user"
  # end
end
