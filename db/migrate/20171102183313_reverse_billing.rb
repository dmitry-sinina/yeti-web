class ReverseBilling < ActiveRecord::Migration
  def up
    execute %q{
      alter table class4.customers_auth add check_account_balance boolean not null default true;
      alter table data_import.import_customers_auth add check_account_balance boolean;


      alter table class4.destinations add reverse_billing boolean not null default false;
      alter table data_import.import_destinations add reverse_billing boolean;

      alter table class4.dialpeers add reverse_billing boolean not null default false;
      alter table data_import.import_dialpeers add reverse_billing boolean;


      alter table class4.gateways
        add max_30x_redirects smallint not null default 0,
        add max_transfers smallint not null default 0;
    }
  end

  def down
    execute %q{
      alter table class4.customers_auth drop column check_account_balance;
      alter table data_import.import_customers_auth drop column check_account_balance;

      alter table class4.destinations drop column reverse_billing;
      alter table data_import.import_destinations drop column reverse_billing;

      alter table class4.dialpeers drop column reverse_billing;
      alter table data_import.import_dialpeers drop column reverse_billing;

      alter table class4.gateways
        drop column max_30x_redirects,
        drop column max_transfers;
    }
  end

end
