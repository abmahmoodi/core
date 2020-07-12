require_dependency "#{Rails.root}/engines/core/app/uploaders/rw/file_uploader"

module Rw
  class Profile < ActiveRecord::Base
    belongs_to :user
    mount_uploader :avatar, Rw::FileUploader
  end
end
