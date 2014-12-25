module Adjutant
  Line = Struct.new(:line) do
    COMMENT_SIGN = "#"
    USERNAME_SIGN = "@"
    TODO_LINE = "TODO:"

    def usefull?()          contain_comment? && point_of_interes?   end

    def contain_comment?()  line.scan(/\+\s*#{COMMENT_SIGN}/).any?  end

    def point_of_interes?() contain_username? || contain_todo?      end
    def contain_username?() line.scan(/(#{USERNAME_SIGN}\w+)/).any? end
    def contain_todo?()     line.scan(/#{TODO_LINE}/).any?          end

    def end_of_comment?()   contain_comment?() ? empty_comment? : true       end
    def empty_comment?()    line.scan(/\+\s*#{COMMENT_SIGN}\s*(\S+)/).empty? end

    def usefull_text
      matched = line.scan(/\+\s*#\s*/).first
      line[matched.size .. -1] unless matched.nil?
    end

  end
end
