module Rw::Payment::PEP
  class NumberToBinary
    include Interactor

    def call
      base = 256
      result = ""
      div = context.number
      while div > 0 do
        mod = div % base
        div = div / base
        result = "#{mod.chr}#{result}"
      end
      context.result = result.rjust(context.block_size, "\x00")
    end
  end
end