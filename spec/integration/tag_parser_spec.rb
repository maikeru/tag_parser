require "tag_parser"

describe TagParser, "#value_for" do
  let(:message) { "do=command data.1=10 data.2=\"we have spaces\" mytag data.3=\"and \nnewlines!\" random=stuff data.4=\"value with \\\"escaped quotes\\\"\" all_alone " }
  context "given a message" do
    context "and the requested tag is 'data.2'" do
      it 'returns "we have spaces"' do
        parser = TagParser.new message
        parser.value_for("data.2").should eq "we have spaces"
      end
    end
  end
end

