Module: yhoti-app

define function main
    (name :: <string>, arguments :: <vector>)
  format-out("%s\n", greeting());
  exit-application(0);
end function;

// Calling our main function (which could have any name) should be the last
// thing we do.
main(application-name(), application-arguments());
