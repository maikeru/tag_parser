require_relative '../lib/tokenizer'

describe Tokenizer, "#tokenize" do
  it "returns [] for an empty input" do
    tokenizer = Tokenizer.new ""
    tokenizer.tokens.should eq []
  end
end
