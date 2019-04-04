class Transfer

  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.status == "pending" && (self.sender.balance - @amount) > 0
      self.sender.deposit(-@amount)
      self.receiver.deposit(@amount)
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    self.sender.deposit(@amount)
    self.receiver.deposit(-@amount)
    self.status = "reversed"
  end

end
