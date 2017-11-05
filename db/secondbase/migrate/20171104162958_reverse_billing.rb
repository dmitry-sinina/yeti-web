class ReverseBilling < ActiveRecord::Migration
  def up
    execute %q{
      alter table cdr.cdr
        add customer_reverse_billing boolean,
        add vendor_reverse_billing boolean,
        add is_redirected boolean;

      alter table cdr.cdr_archive
        add customer_reverse_billing boolean,
        add vendor_reverse_billing boolean;
        add is_redirected boolean;

    }
  end
end
