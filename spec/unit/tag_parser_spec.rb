require 'tag_parser'

describe TagParser, "#value_for" do
  let(:parser) do
    TagParser.new 'name=value data.1="spaced value" tag'
  end
  context "a tag with no value" do
    it "returns an empty string" do
      parser.value_for("tag").should eq ""
    end
  end
  context "a tag with an unquoted value" do
    it "returns the value" do
      parser.value_for("name").should eq "value"
    end
  end
  context "a tag with a quoted value" do
    it "returns the value" do
      parser.value_for("data.1").should eq "spaced value"
    end
  end
  context "a non-existent tag" do
    it "throws an exception" do
      expect { parser.value_for("missing_tag") }.to raise_error
    end
  end
end

describe TagParser, "#tags_at" do
  let(:message) { "data.1.name=hello data.1.value=world" }
  context 'with the path "data.1."' do
    it "returns a list of the tags and values at that path" do
      @parser = TagParser.new message
      expected = { :name => "hello", :value => "world" }
      @parser.tags_at("data.1.").should eq expected
    end
  end
end
