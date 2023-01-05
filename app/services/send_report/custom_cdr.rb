# frozen_string_literal: true

module SendReport
  class CustomCdr < Base
    private

    def email_subject
      'Custom CDR report'
    end

    def csv_data
      [
        CsvData.new(report.csv_columns, report.report_records)
      ]
    end

    def email_data
      [
        EmailData.new(email_columns, report.report_records, ReportCustomDataDecorator)
      ]
    end

    def email_columns
      report.auto_columns.map(&:first) + [
        [:agg_calls_count, 'Calls count'],
        [:decorated_agg_calls_duration, 'Duration'],
        [:decorated_agg_calls_acd, 'ACD'],
        [:decorated_agg_asr_origination, 'Origination ASR'],
        [:decorated_agg_asr_termination, 'Termination ASR'],
        [:decorated_agg_vendor_price, 'Termination cost'],
        [:decorated_agg_customer_price, 'Origination cost'],
        [:decorated_agg_profit, 'Profit']
      ]
    end
  end
end
