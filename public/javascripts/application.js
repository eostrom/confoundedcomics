// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Event.addBehavior({
  '#archive h2 a:click': function(event) {
    Event.stop(event);
  }
});
