module Rw
  class ApplicationMailer < ActionMailer::Base
    default from: 'MAIL@gmail.com'
    layout 'mailer'
  end
end

