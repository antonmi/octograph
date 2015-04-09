console.log("fffffffffffffffffdghdgfhdfghdg");
var AppView = Backbone.View.extend({
  // el - stands for element. Every view has a element associate in with HTML
  //      content will be rendered.
  el: '#right-side',
  // It's the first function called when this view it's instantiated.
  initialize: function(){
    this.render();
  },

  template: _.template("<h3>Hello <%= who %>"),
  // $el - it's a cached jQuery object (el), in which you can use jQuery functions
  //       to push content. Like the Hello World in this case.
  render: function(){
    this.$el.html(this.template({who: 'world'}));
  }
});

var app = {};


app.NodeList = Backbone.Collection.extend({
  model: app.Node,
  url: '/nodes'
})


app.Node = Backbone.Model.extend({
  defaults: {
    label: 'no label'
  }
})
