class GenerateCodeForUser
  include Interactor

  def call
    context.code = Rw::User.
        joins('INNER JOIN rw_user_types ut ON ut.id = rw_users.user_type').
        where('ut.title=?', 'collector').
        maximum(:code).to_i + 1
  end
end