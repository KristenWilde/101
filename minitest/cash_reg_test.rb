require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < MiniTest::Test
  attr_reader :shoes, :register

  def setup
    @register = CashRegister.new(200)
    @shoes = Transaction.new(80)
    shoes.amount_paid = 100
  end

  def test_accept_money
    assert_equal(300, register.accept_money(shoes))
  end
  
  def test_change
    assert_equal(20, register.change(shoes))
  end
  
  def test_give_receipt
    assert_output("You've paid $80.\n") { register.give_receipt(shoes) }
  end

  def test_prompt_for_payment
    shoes.prompt_for_payment(input: StringIO.new('90\n'), output: StringIO.new)
    assert_equal(90, shoes.amount_paid)
  end
end
