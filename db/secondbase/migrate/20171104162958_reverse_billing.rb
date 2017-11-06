class ReverseBilling < ActiveRecord::Migration
  def up
    execute %q{
      alter table cdr.cdr
        add destination_reverse_billing boolean,
        add dialpeer_reverse_billing boolean,
        add is_redirected boolean,
        add customer_account_check_balance boolean;

      alter table cdr.cdr_archive
        add destination_reverse_billing boolean,
        add dialpeer_reverse_billing boolean,
        add is_redirected boolean,
        add customer_account_check_balance boolean;

    }
  end

  def down
    execute %q{

    alter table cdr.cdr
        drop column destination_reverse_billing,
        drop column dialpeer_reverse_billing,
        drop column is_redirected,
        drop column customer_account_check_balance;

      alter table cdr.cdr_archive
        drop column destination_reverse_billing,
        drop column dialpeer_reverse_billing,
        drop column is_redirected,
        drop column customer_account_check_balance;

    }
  end
end
