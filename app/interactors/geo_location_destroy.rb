class GeoLocationDestroy
  include Interactor

  def call
    Rw::Authorize.call(context.user, GeoLocationPolicy, :destroy?)

    unless Rw::GeoLocation.destroy_all(id: context.id)
      context.fail!
      context.error = 'خطا'
    end
  end
end
