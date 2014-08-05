module Adjutant
  Comment = Struct.new(:text) do
    def add(comment)
      self.text = empty? ? comment : text.concat("\\n").concat(comment)
    end

    def empty?
      text.nil? || text.empty?
    end

    def reset
      self.text = nil
    end

    def print(index)
      [ text, index ]
    end
  end
end
