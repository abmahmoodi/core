module Rw
  module ApplicationHelper
    def bootstrap_class_for flash_type
      case flash_type.to_s
      when 'notice'
        'alert-info'
      when 'alert'
        'alert-warning'
      when 'success'
        'alert-success'
      when 'error'
        'alert-danger'
      when 'alert'
        'alert-warning'
      end
    end

    def flash_messages(opts = {})
      flash.each do |msg_type, message|
        return if (message.blank?) or (msg_type == 'timedout')
        concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
          concat content_tag(:i, '', class: 'fa fa-times close', data: { dismiss: 'alert' })
          concat message
        end)
      end
      nil
    end
    
    def title(page_title)
      content_for :title, page_title.to_s
    end
  end
end
