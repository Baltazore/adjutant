require 'logger'

module Adjutant
  class FileParser

    attr_reader :comment

    def initialize(file)
      @text = file[:patch]
      @comment = Comment.new("")
      @comments = []
      @previous_was_usefull = false
    end

    def detect_comments
      lines_pushed.each_with_index do |line, index|
        line = Line.new(line)
        if line.usefull? || @previous_was_usefull
          parse_line(line, index)
        else
          push_comment and next
        end
      end

      push_comment if @previous_was_usefull
      @comments
    end

    def push_comment
      @comments << @comment.print unless comment.text.nil?
      @comment.reset
      @previous_was_usefull = false
    end

    def parse_line(line, index)
      if line.end_of_comment?
        push_comment
      else
        @comment.add line.usefull_text, index
        @previous_was_usefull = true
      end
    end

    def lines_pushed
      @text
        .split(/(\n)/)
        .delete_if { |e| e[0] != "+" }
    end
  end
end
