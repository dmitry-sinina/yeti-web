select pgq.create_queue('cdr_billing');
select pgq.register_consumer('cdr_billing','cdr_billing');
select pgq.create_queue('cdr_streaming');
select pgq.create_queue('rtp_statistics');
select pgq.create_queue('rtp_rx_stream');
select pgq.create_queue('rtp_tx_stream');
