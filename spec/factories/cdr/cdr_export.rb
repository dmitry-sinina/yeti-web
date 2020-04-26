# frozen_string_literal: true

FactoryGirl.define do
  factory :cdr_export, class: CdrExport do
    type 'Base'
    callback_url nil
    filters do
      {
        time_start_gteq: '2018-01-01',
        time_start_lteq: '2018-03-01'
      }
    end
    fields %i[success id]
    status nil

    trait :completed do
      status CdrExport::STATUS_COMPLETED
    end
  end
end
