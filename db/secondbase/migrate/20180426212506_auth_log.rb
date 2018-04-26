class AuthLog < ActiveRecord::Migration
  def up
    execute %q{
      create schema auth_log;
      create table auth_log.auth_log (
        id bigserial primary key,
        request_time timestamptz not null default now(),
        sign_orig_ip varchar,
        sign_orig_port integer,
        sign_orig_local_ip varchar,
        sign_orig_local_port integer,
        auth_orig_ip varchar,
        auth_orig_port integer,
        ruri varchar,
        from_uri varchar,
        to_uri varchar,
        orig_call_id varchar,
        success boolean not null default false,
        code smallint,
        reason varchar,
        internal_reason varchar,
        nonce varchar,
        response varchar,
        gateway_id integer
      );
    }
  end
end
