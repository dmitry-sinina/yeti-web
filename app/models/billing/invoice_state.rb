# == Schema Information
#
# Table name: billing.invoice_states
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class Billing::InvoiceState < Cdr::Base

  self.table_name='billing.invoice_states'

  PENDING = 1
  APPROVED = 2
  GENERATION_WAITING = 3
  GENERATION = 4
  DELETION_WAITING = 5
  DELETION = 6

  #creating flow:
  #GENERATION_WAITING -> GENERATING -> PENDING

  #deletion flow
  #PENDING/APPROVED -> DELETION_WAITING -> DELETION

  COLORS = {
      1=>:red,
      2=>:orange,
      3=>:grey,
      4=>:green,
      5=>:red,
      6=>:red
  }.freeze

  def color
      return COLORS[self.id]
  end

end
