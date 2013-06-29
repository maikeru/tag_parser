require_relative '../lib/tokenizer'

describe Tokenizer, "#tokenize" do
  context "when input is empty string" do
    it "returns []" do
      tokenizer = Tokenizer.new ""
      tokenizer.tokens.should eq []
    end
  end
  context "when input is 'mytag'" do
    it "returns a tag token" do
      tokenizer = Tokenizer.new "mytag"
      tokenizer.tokens.should eq([{ tag_only: ["mytag"] }])
    end
  end

  # [{:tag_with_value=>["do", "command"]},
  #  {:tag_with_value=>["data.1", "10"]},
  #  {:tag_with_quoted_value=>["data.2", "we have spaces"]},
  #  {:tag_only=>["mytag", nil]},
  #  {:tag_with_quoted_value=>["data.3", "and \nnewlines!"]},
  #  {:tag_with_value=>["random", "stuff"]},
  #  {:tag_with_quoted_value=>["data.4", "value with \\\"escaped quotes\\\""]},
  #  {:tag_only=>["all_alone", nil]}]
end
