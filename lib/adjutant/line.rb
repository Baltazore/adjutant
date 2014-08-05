module Adjutant
  Line = Struct.new(:line) do
    COMMENT_SIGN = "#"
    USERNAME_SIGN = "@"
    TODO_LINE = "TODO:"

    def usefull?; contain_comment? && point_of_interes? && new_added? end

    def contain_comment?() line.scan(/\+\s*#{COMMENT_SIGN}/).any? end

    def point_of_interes?() contain_username? || contain_todo? end

    def contain_username?() line.scan(/(#{USERNAME_SIGN}\w+)/).any? end
    def contain_todo?() line.scan(/#{TODO_LINE}/).any? end

    def new_added?() line[0] == '+' end

    def end_of_comment?
      return true unless contain_comment?

      empty_comment?
    end
    def empty_comment?() line.scan(/\+\s*#{COMMENT_SIGN}\s*(\S+)/).empty? end

    def usefull_text
      matched = line.scan(/\+\s*#\s*/).first
      line[matched.size .. -1] unless matched.nil?
    end

  end
end
