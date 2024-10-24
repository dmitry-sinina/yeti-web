# frozen_string_literal: true

# == Schema Information
#
# Table name: dialpeer_next_rates
#
#  id               :bigint(8)        not null, primary key
#  applied          :boolean          default(FALSE), not null
#  apply_time       :datetime         not null
#  connect_fee      :decimal(, )      not null
#  initial_interval :integer(2)       not null
#  initial_rate     :decimal(, )      not null
#  next_interval    :integer(2)       not null
#  next_rate        :decimal(, )      not null
#  created_at       :datetime         not null
#  updated_at       :datetime
#  dialpeer_id      :bigint(8)        not null
#  external_id      :bigint(8)
#
# Foreign Keys
#
#  dialpeer_next_rates_dialpeer_id_fkey  (dialpeer_id => dialpeers.id)
#

class DialpeerNextRate < ApplicationRecord
  validates :dialpeer, presence: true
  validates :next_rate,
                        :initial_rate,
                        :initial_interval,
                        :next_interval,
                        :connect_fee,
                        :apply_time, presence: true

  validates :initial_interval, :next_interval, numericality: { greater_than: 0 } # we have DB constraints for this
  validates :next_rate, :initial_rate, :connect_fee, numericality: true

  belongs_to :dialpeer

  scope :not_applied, -> { where(applied: false) }
  scope :applied, -> { where(applied: true) }

  include WithPaperTrail

  scope :ready_for_apply, lambda {
    not_applied.where('apply_time < ?', Time.now.utc).preload(:dialpeer)
  }
end
