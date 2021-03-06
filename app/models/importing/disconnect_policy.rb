# frozen_string_literal: true

# == Schema Information
#
# Table name: import_disconnect_policies
#
#  id           :integer          not null, primary key
#  o_id         :integer
#  name         :string
#  error_string :string
#  is_changed   :boolean
#

class Importing::DisconnectPolicy < Importing::Base
  self.table_name = 'import_disconnect_policies'

  self.import_attributes = ['name']
  import_for ::DisconnectPolicy
end
