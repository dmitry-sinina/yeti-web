FactoryGirl.define do
  factory :auth_log, class: Cdr::AuthLog do
    request_time                { 1.minute.ago }
    code                        {200}
    reason 'OK'
    internal_reason 'Response matched'
    origination_ip '1.1.1.1'
    origination_port 5060
    transport_remote_ip '2.2.2.2'
    transport_remote_port 6050
    transport_local_ip '2.2.2.2'
    transport_local_port 6050
    username 'User1'
    realm 'Realm1'
    request_method 'INVITE'
    call_id '2b8a45f5730c1b3459a00b9c322a79da'
    success                     true

    transport_protocol { Equipment::TransportProtocol.take }
    origination_protocol { Equipment::TransportProtocol.take }

    # association :transport_protocol, factory: :transport_protocol
    # association :origination_protocol, factory: :transport_protocol

    association :gateway, factory: :gateway
    association :pop, factory: :pop
    association :node, factory: :node

    trait :with_id do
      id { Cdr::AuthLog.connection.select_value("SELECT nextval('auth_log.auth_log_id_seq')").to_i }
    end

    before(:create) do |record, evaluator|
      # Create partition for current+next monthes if not exists
      Cdr::AuthLogTable.add_partition
    end

  end
end
