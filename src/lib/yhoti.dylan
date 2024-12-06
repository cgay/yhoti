Module: yhoti-impl

// Internal
define constant $greeting = "Hello world!";

// Exported
define function greeting () => (s :: <string>)
  $greeting
end function;
