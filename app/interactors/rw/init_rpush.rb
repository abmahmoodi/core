module Rw
  class InitRpush
    include Interactor

    def call
      if Rpush::Gcm::App.find_by_name("ir.behsazenergy") == nil
        app = Rpush::Gcm::App.new
        app.name = "ir.behsazenergy"
        app.auth_key = "AIzaSyAOip_MIDU_siAQxLOwC7JiKtZb00PX-HQ"
        app.connections = 1
        app.save!
      end
    end
  end
end