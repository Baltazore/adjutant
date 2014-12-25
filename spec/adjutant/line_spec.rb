require 'spec_helper'

RSpec.describe Adjutant::Line do
  let(:comment) { "+# @baltazore don't forget to write specs!" }
  let(:todo)    { "+    # TODO: write moar specs!" }
  let(:empty)   { "+    #" }
  let(:useless) { "class Line" }

  describe '#usefull?' do

    context '#contain_comment?' do
      it 'return true if line contain comment' do
        expect(Adjutant::Line.new(comment).contain_comment?).to eq(true)
        expect(Adjutant::Line.new(todo).contain_comment?).to eq(true)
        expect(Adjutant::Line.new(empty).contain_comment?).to eq(true)
      end

      it 'return false in other cases' do
        expect(Adjutant::Line.new(useless).contain_comment?).to eq(false)
      end
    end

    describe '#point_of_interes?' do

      context '#contain_username' do
        it 'return true if line contain username' do
          expect(Adjutant::Line.new(comment).contain_username?).to eq(true)
        end

        it 'return false in other cases' do
          expect(Adjutant::Line.new(todo).contain_username?).to eq(false)
          expect(Adjutant::Line.new(empty).contain_username?).to eq(false)
          expect(Adjutant::Line.new(useless).contain_username?).to eq(false)
        end
      end

      context '#contain_todo' do
        it 'return true if line contain todo' do
          expect(Adjutant::Line.new(todo).contain_todo?).to eq(true)
        end

        it 'return false in other cases' do
          expect(Adjutant::Line.new(comment).contain_todo?).to eq(false)
          expect(Adjutant::Line.new(empty).contain_todo?).to eq(false)
          expect(Adjutant::Line.new(useless).contain_todo?).to eq(false)
        end
      end

      it 'returns true if line is comment line and interesting for us' do
        expect(Adjutant::Line.new(comment).point_of_interes?).to eq(true)
        expect(Adjutant::Line.new(todo).point_of_interes?).to eq(true)
      end

      it 'returns false in other cases' do
        expect(Adjutant::Line.new(empty).point_of_interes?).to eq(false)
        expect(Adjutant::Line.new(useless).point_of_interes?).to eq(false)
      end
    end

  end

  describe '#usefull_text' do
    it 'returns usefull text from line' do
      comment_text = "@baltazore don't forget to write specs!"
      todo_text    = "TODO: write moar specs!"
      expect(Adjutant::Line.new(comment).usefull_text).to eq(comment_text)
      expect(Adjutant::Line.new(todo).usefull_text).to eq(todo_text)
      expect(Adjutant::Line.new(empty).usefull_text).to eq("")
      expect(Adjutant::Line.new(useless).usefull_text).to eq(nil)
    end
  end

  describe '#end_of_comment?' do
    context '#empty_comment?' do
      it 'returns true if comment is empty' do
        expect(Adjutant::Line.new(empty).empty_comment?).to eq(true)
      end

      it 'returns false in other cases' do
        expect(Adjutant::Line.new(comment).empty_comment?).to eq(false)
        expect(Adjutant::Line.new(todo).empty_comment?).to eq(false)
      end
    end

    it 'returns true if comment is ended' do
      expect(Adjutant::Line.new(empty).end_of_comment?).to eq(true)
      expect(Adjutant::Line.new(useless).end_of_comment?).to eq(true)
    end

    it 'returns false in other cases' do
      expect(Adjutant::Line.new(comment).end_of_comment?).to eq(false)
      expect(Adjutant::Line.new(todo).end_of_comment?).to eq(false)
    end
  end
end
