class UserForm < Reform::Form
  model 'rw/user'

  property :password
  property :password_confirmation, virtual: true
  property :email
  property :user_type

  property :profile do
    property :first_name
    property :last_name
    property :mobile
    property :address
    property :sheba
    property :avatar
  end

  validates :password, length: { minimum: 3 }
  validates_uniqueness_of :email
  validates :email, email_format: true
  validate :password_ok?

  private

  def password_ok?
    return unless password != password_confirmation
    errors.add(:password_confirmation,
                            I18n.t(:'activemodel.errors.models.rw/user.attributes.password_confirmation.confirmation'))
  end
end