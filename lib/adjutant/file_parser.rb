module Adjutant
  class FileParser

    attr_reader :comment

    def initialize(file)
      @text = file[:patch]
      @comment = Comment.new("")
      @comments = []
    end

    def detect_comments
      usefull = false
      lines_pushed.each_with_index do |line, index|
        line = Line.new(line)

        if line.usefull? || usefull
          usefull = true
          parse_line(line, index)
        else
          push_comment
          usefull = false

          next
        end
      end
      push_comment if usefull
      @comments
    end

    def push_comment
      @comments << @comment.print
      @comment.reset
    end

    def parse_line(line, index)
      if line.end_of_comment?
        push_comment
      else
        @comment.add line.usefull_text, index
      end
    end

    def lines_pushed
      @text
        .split(/(\n)/)
        .delete_if { |e| e[0] != "+" }
    end
  end
end
