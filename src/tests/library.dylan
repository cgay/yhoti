Module: dylan-user

define library yhoti-test-suite
  use common-dylan;
  use testworks;
  use yhoti;
end library;

define module yhoti-test-suite
  use common-dylan;
  use testworks;
  use yhoti;
  use yhoti-impl;
end module;
