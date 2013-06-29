require_relative '../ragel/state_machine'
class Tokenizer
  attr_reader :tokens
  def initialize input
    @input = input
    @tokens = tokenize
  end

  def tokenize
    return [] if @input.empty?
    StateMachine.run_lexer @input
  end
end
