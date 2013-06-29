require 'tokenizer'
class TagParser
  def initialize input
    @tokens = Tokenizer.new(input).tokens
  end

  def value_for tag
    @tokens.each do |token|
      token.each do |token_type, token_content|
        if token_content[0] == tag
          return token_content.fetch(1, "")
        end
      end
    end
    raise Exception
  end
end
