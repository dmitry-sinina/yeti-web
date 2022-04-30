# frozen_string_literal: true

module Jobs
  class PartitionRemoving < ::BaseJob
    self.cron_line = '20 * * * *'

    def execute
      remove_partition! PartitionModel::Cdr, Cdr::Cdr
      remove_partition! PartitionModel::Cdr, Cdr::AuthLog
      remove_partition! PartitionModel::Cdr, Cdr::RtpStatistic
      remove_partition! PartitionModel::Cdr, RtpStatistics::TxStream
      remove_partition! PartitionModel::Cdr, RtpStatistics::RxStream
      remove_partition! PartitionModel::Log, Log::ApiLog
    end

    private

    def partition_remove_delay
      YetiConfig.partition_remove_delay
    end

    def remove_partition!(partition_class, model_class)
      table_name = model_class.table_name
      remove_delay = partition_remove_delay[table_name]
      if remove_delay.blank?
        logger.info { "#{self.class}: blank remove delay for #{table_name}" }
        return
      end

      # has format /\A\d+ days\z/
      remove_delay = remove_delay.split(' ').first.to_i
      cdr_collection = partition_class
                       .where(parent_table_eq: table_name)
                       .to_a
                       .select { |r| r.date_to <= remove_delay.days.ago.utc }
                       .sort_by(&:date_to)

      if cdr_collection.empty?
        logger.info { "#{self.class}: does not enough partitions for #{table_name}" }
        return
      end

      cdr_remove_candidate = cdr_collection.first
      cdr_remove_candidate.destroy!
    rescue ActiveRecord::RecordNotDestroyed => e
      logger.error { "#{self.class}: {#{table_name}} #{cdr_remove_candidate&.name} - #{e.message}" }
      capture_error(e, extra: { partition_class: partition_class, model_class: model_class })
    rescue StandardError => e
      logger.error { "#{self.class}: {#{table_name}} <#{e.class}>: #{e.message}\n#{e.backtrace.join("\n")}" }
      capture_error(e, extra: { partition_class: partition_class.name, model_class: model_class.name })
      raise e
    end
  end
end
