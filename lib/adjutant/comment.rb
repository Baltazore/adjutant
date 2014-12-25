module Adjutant
  Comment = Struct.new(:text, :index) do
    def initialize(*)
      super
      self.index ||= 0
    end

    def add(comment, index)
      self.index = index + 1 if empty?
      self.text =
        if empty?
          comment.to_s
        else
          "#{self.text}\n#{comment}"
        end
    end

    def empty?
      self.text.nil? || self.text.empty?
    end

    def reset
      self.text = nil
    end

    def print
      [ self.text, self.index ]
    end
  end
end
