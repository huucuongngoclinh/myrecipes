// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);

window.setTimeout(function() {
	$(".alert").fadeTo(500, 0).slideUp(500, function(){
		$(this).remove(); 
	});
}, 3000);