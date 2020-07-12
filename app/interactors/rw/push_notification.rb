module Rw
  class PushNotification
    include Interactor

    def call
      Rw::InitRpush.call
      notification = Rpush::Gcm::Notification.new
      notification.app = Rpush::Gcm::App.find_by_name(context.app_name)
      notification.registration_ids = [context.fcm_token]
      notification.data = context.data
      notification.priority = 'high' # Optional, can be either 'normal' or 'high'
      notification.content_available = true # Optional
      notification.notification = {body: context.body,
                        title: context.title,
                        icon: 'myicon'}
      notification.save!
    end
  end
end