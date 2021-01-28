require 'pry'

class Transfer

  attr_accessor :sender, :receiver, :status, :amount, :bank_account

  def initialize(sender,receiver,amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount

  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if self.status == "pending" && valid? == true && sender.balance > amount
      receiver.deposit(amount)
      sender.deposit(-amount)
      sender.display_balance
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete" && valid? == true && receiver.balance > amount
      receiver.balance -= amount
      sender.balance += amount
      self.status = "reversed"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
    
  end

end
