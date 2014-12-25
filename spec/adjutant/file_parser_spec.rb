require 'spec_helper'

RSpec.describe Adjutant::FileParser do

  let(:file) do
    { :patch=> "@@ -0,0 +1,14 @@\n+# @Baltazore is trying to check first line comment\n+def super_method(such_args)\n+ \"Doge tutorial\"\n+end\n+# useless comment\n+\"hello world\"\n+# @baltazore, Let's check multiline comments,\n+# them really rocks\n+#\n+\n+# TODO:\n+# - [ ] This Github flavoured markdown\n+# - [ ] such nice\n+# - [ ] very exciting" }
  end

  let(:lines) do
    [
      "+# @Baltazore is trying to check first line comment",
      "+def super_method(such_args)",
      "+ \"Doge tutorial\"",
      "+end",
      "+# useless comment",
      "+\"hello world\"",
      "+# @baltazore, Let's check multiline comments,",
      "+# them really rocks",
      "+#",
      "+",
      "+# TODO:",
      "+# - [ ] This Github flavoured markdown",
      "+# - [ ] such nice",
      "+# - [ ] very exciting",
    ]
  end

  let(:comments) do
    [
      [ "@Baltazore is trying to check first line comment", 1 ],
      [ "@baltazore, Let's check multiline comments,\nthem really rocks", 7],
      [ "TODO:\n- [ ] This Github flavoured markdown\n- [ ] such nice\n- [ ] very exciting", 11 ]
    ]
  end
  let(:file_parser) { Adjutant::FileParser.new(file) }

  describe '#detect_comments' do
    it 'fineds only 3 comments here' do
      expect(file_parser.detect_comments.count).to eq(3)
    end

    context '#lines_pushed' do
      it 'returns all lines that has been pushed in commit' do
        file_parser.lines_pushed.each_with_index do |line, index|
          expect(line).to eq(lines[index])
        end
      end
    end

    context '#parse_line' do
      it 'should create a comment from pushed lines' do
        line = Adjutant::Line.new(lines[0])
        file_parser.parse_line(line, 0)
        expect(file_parser.comment.text).to eq(comments[0][0])
      end
    end

    it 'returns all comment, that catch up' do
      file_parser.detect_comments.each_with_index do |comment, index|
        expect(comment).to eq(comments[index])
      end
    end
  end

end
