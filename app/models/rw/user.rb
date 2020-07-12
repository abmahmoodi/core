module Rw
  class User < ActiveRecord::Base
    has_one :profile, class_name: 'Rw::Profile', dependent: :destroy
    before_create :generate_token, :generate_auth_token

    if ActiveRecord::Base.connection.data_source_exists? 'rw_user_types'
      types = Rw::UserType.pluck(:title)
      types.each do |t|
        define_method("#{t}?") do
          is_type?(self.id, t)
        end
      end
    end

    def self.user_email(user_id)
      self.where(id: user_id).pluck(:email)[0]
    end

    def self.user_type(user_id)
      self.joins('LEFT JOIN rw_user_types ut ON ut.id = rw_users.user_type').
          where(id: user_id).pluck("ut.title")[0].to_sym
    end

    include Token
    authenticates_with_sorcery!

    private

    def is_type?(user_id, user_type)
      Rw::HasType.call(id: user_id, user_type: user_type).success?
    end

    protected

    def generate_token
      self.slug = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Rw::User.exists?(slug: random_token)
      end
    end

    def generate_auth_token
      self.auth_token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Rw::User.exists?(auth_token: random_token)
      end
    end
  end
end
