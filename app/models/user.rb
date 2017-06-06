class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role, optional: true
  has_many :pictures

  validates :first_name, :last_name, :email, presence: true

  before_save :default_values

  default_scope -> {
    includes(:role).all
  }

  scope :active, lambda {
    where(active: true)
  }

  def default_values
    puts "==========default values========="
    userRole = Role.find_by_name('User')
    puts userRole
    self.role ||= userRole
    self
  end

  def admin?
    if role
      role.name == 'Admin'
    else
      false
    end
  end

  def role_is?(arole)
    if role
      role.name.downcase.parameterize.underscore.to_sym == arole
    else
      false
    end
  end

  def has_permission?(permission)
    Role.where("id = ? and ? = ANY (permissions)", role_id, permission).size > 0
  end

  # Devise Helper Methods
  def active_for_authentication?
    super && self.active
  end

  def inactive_message
    "Sorry, this account has been deactivated."
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
