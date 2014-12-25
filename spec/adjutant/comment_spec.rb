require 'spec_helper'

RSpec.describe Adjutant::Comment do
  let(:message) { "Hey there!" }
  let(:index)   { 42 }

  it 'creates an comment with given text' do
    comment = Adjutant::Comment.new(message)
    expect(comment.text).to eq(message)
  end

  describe '#empty?' do
    it 'return false if text is present' do
      comment = Adjutant::Comment.new(message)
      expect(comment.empty?).to eq(false)
    end

    it 'return true if text is nil' do
      comment = Adjutant::Comment.new
      expect(comment.empty?).to eq(true)
    end

    it 'return true if text is empty' do
      comment = Adjutant::Comment.new("")
      expect(comment.empty?).to eq(true)
    end
  end

  describe '#add' do
    let(:part1)   { "Hello" }
    let(:part2)   { "world!" }
    let(:text)    { "Hello\nworld!" }

    it 'adds new text to empty comment' do
      comment = Adjutant::Comment.new
      comment.add(part1, 0)
      expect(comment.text).to eq(part1)
    end

    it 'adds new text to comment with adding new line' do
      comment = Adjutant::Comment.new(part1)
      comment.add(part2, 0)
      expect(comment.text).to eq(text)
    end
  end

  describe '#reset' do
    it 'is able to reset text for comment' do
      comment = Adjutant::Comment.new(message)
      expect(comment.text).to eq(message)
      comment.reset
      expect(comment.text).to eq(nil)
    end
  end

  describe '#print' do
    let(:message2) { "I'm here" }
    it 'returns comemnt with default index to push as comment' do
      comment = Adjutant::Comment.new(message)
      expect(comment.print).to eq([message, 0])
    end

    it 'returns comemnt with first index to push as comment' do
      comment = Adjutant::Comment.new
      comment.add(message, index)
      comment.add(message2, index+1)
      expect(comment.print).to eq([message+"\n"+message2, index+1])
    end
  end

end
