require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < Minitest::Test
  def test_prompt_for_payment
    transaction = Transaction.new(30)
    input = StringIO.new('40\n')
    transaction.prompt_for_payment(input: input)
    assert_equal 40, transaction.amount_paid
  end
end