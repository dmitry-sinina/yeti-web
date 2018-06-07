# == Schema Information
#
# Table name: class4.transport_protocols
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class Equipment::TransportProtocol < Yeti::ActiveRecord
  self.table_name='class4.transport_protocols'

  def display_name
    self.name
  end

end
