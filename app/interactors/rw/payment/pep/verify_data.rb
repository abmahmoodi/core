module Rw::Payment::PEP
  class VerifyData
    include Interactor

    def call
      number = BinaryToNumber.call(data: context.message).result
      decrypted = PowMod.call(p: number, q: context.public_key, r: context.modulus).result
      result = NumberToBinary.call(number: decrypted.to_i, block_size: context.key_length / 8).result
      context.result = remove_pkcs1_padding(result, context.key_length / 8)
    end

    private

    def remove_pkcs1_padding(data, block_size)
      data = data[1..-1]
      # data = data.delete("\x00")
      if data[0] == "\x00"
        raise('ERROR')
      end
      offset = data.index("\0")
      data[(offset+1)..-1]
    end
  end
end