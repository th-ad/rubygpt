# frozen_string_literal: true

require "torch-rb"
require_relative "./tokenizer.rb"

text = File.read("./shakespeare_input.txt")

vocab = text.chars.uniq.sort
tokenizer = Tokenizer.new(vocab)

data = Torch.tensor(tokenizer.encode(text))

training_data_size = (0.9 * data.length).to_i
training_data = data[...training_data_size]
validation_data = data[training_data_size..]

batch_size = 4
block_size = 8

# TODO: dtype should default to :int64 in torch-rb
random_indices = Torch.randint(0, data.length - block_size, [batch_size], dtype: :int64)

# These indicies need to be converted to integers before generating ranges due to a bug in torch-rb
context = Torch.stack(random_indices.map { |i| data[i.to_i...(i + block_size).to_i] })
targets = Torch.stack(random_indices.map { |i| data[(i + 1).to_i...(i + block_size + 1).to_i] })
