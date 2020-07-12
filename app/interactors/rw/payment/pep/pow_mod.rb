module Rw::Payment::PEP
  class PowMod
    include Interactor

    def call
      factors = []
      div = context.q.to_i
      power_of_two = 0
      while div > 0 do
        rem = div % 2
        div = div / 2
        if rem.to_i > 0
          factors << power_of_two
        end
        power_of_two += 1
      end
      partial_results = []
      part_res = context.p.to_i
      idx = 0
      factors.each do |factor|
        while idx < factor do
          part_res = part_res ** 2
          part_res = part_res % context.r.to_i
          idx += 1
        end
        partial_results << part_res
      end

      result = 1
      partial_results.each do |res|
        result = result * res
        result = result % context.r.to_i
      end
      context.result = result.to_s
    end
  end
end