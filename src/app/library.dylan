Module: dylan-user
Synopsis: Module and library definition for executable application

define library yhoti-app
  use common-dylan;
  use yhoti;
  use io, import: { format-out };
end library;

define module yhoti-app
  use common-dylan;
  use format-out;
  use yhoti;
end module;
