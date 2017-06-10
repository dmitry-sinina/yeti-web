begin;
insert into sys.version(number,comment) values(48,'Asynchronous invoice generation');

insert into billing.invoice_states(id,name)
  values (3,'Generation waiting'), (4,'Generation'), (5,'Deletion waiting'), (6,'Deletion');

commit;
