module Rw::Payment::PEP
  class BinaryToNumber
    include Interactor

    def call
      base = 256
      radix = 1
      result = 0
      (context.data.length - 1).downto(0).each do |i|
        digit = context.data[i].ord
        part_res = digit * radix
        result += part_res
        radix *= base
      end
      context.result = result.to_s
    end
  end
end