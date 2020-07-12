module Rw
  class ErrorsClass
    include Interactor
    class PermissionError < StandardError; end

    def call
      context.permission_error = PermissionError
    end
  end
end