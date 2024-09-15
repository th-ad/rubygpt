# frozen_string_literal: true
class Tokenizer
  attr_reader :decoding_map, :encoding_map, :vocab

  def initialize(vocab)
    @vocab = vocab
    @decoding_map = vocab.to_h { |c| [c.ord, c] }
    @encoding_map = vocab.to_h { |c| [c, c.ord] }
  end

  def encode(text)
    text.chars.map { |c| encoding_map[c] }
  end

  def decode(arr)
    arr.map { |c| decoding_map[c] }.join
  end
end
