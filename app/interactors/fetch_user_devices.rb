class FetchUserDevices
  include Interactor

  def call
    user_id = context.view.params[:user_id]
    raise I18n.t(:'messages.permission_denied') unless UserDevicePolicy.new(context.view.current_user, :user_device).index?

    user_devices = Rw::Devices::UserDevice.joins(:device).select("device_id,name,imei,description").where(user_id:user_id)
    context.result = user_devices

    if context.view.params[:sSearch].present?
      user_devices = user_devices.where('name LIKE :search',
                                            search: "%#{context.view.params[:sSearch]}%")
    end

    user_device_datatable = Rw::ServerSideDatatable.new(context.view, user_devices, %w[name imei description])
    user_devices = user_device_datatable.fetch_model

    userhash_devices =
        user_devices.map do |user_device|
          [
              user_device.device.name,
              user_device.device.imei,
              user_device.device.description
          ]
        end
    context.result = user_device_datatable.as_json(userhash_devices)
  end
end
