require 'tokenizer'

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
  context "when input is a long message" do
    it "should return an array of tokens" do
      message = "do=command data.1=10 data.2=\"we have spaces\" mytag data.3=\"and \nnewlines!\" random=stuff data.4=\"value with \\\"escaped quotes\\\"\" all_alone "
      expected = [{:tag_with_value=>["do", "command"]},
        {:tag_with_value=>["data.1", "10"]},
        {:tag_with_quoted_value=>["data.2", "we have spaces"]},
        {:tag_only=>["mytag"]},
        {:tag_with_quoted_value=>["data.3", "and \nnewlines!"]},
        {:tag_with_value=>["random", "stuff"]},
        {:tag_with_quoted_value=>["data.4", "value with \\\"escaped quotes\\\""]},
        {:tag_only=>["all_alone"]}]
      tokenizer = Tokenizer.new message
      tokenizer.tokens.should eq expected
    end
  end
end
