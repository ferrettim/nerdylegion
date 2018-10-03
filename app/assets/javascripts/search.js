window.addEventListener("load", function() {
  $input = $("[data-behavior='autocomplete']")

  var options = {
    getValue: "title",
    url: function(phrase) {
      return "/search.json?q=" + phrase;
    },
    categories: [
      {
        listLocation: "episodes",
        header: "<strong>Episodes</strong>",
      },
      {
        listLocation: "podcasts",
        header: "<strong>Podcasts</strong>",
      }
    ],
    template: {
  		type: "iconLeft",
  		fields: {
  			iconSrc: "icon"
  		}
  	},
    theme: "blue-light",
    list: {
      onChooseEvent: function() {
        var url = $input.getSelectedItemData().url
        $input.val("")
        window.location = (url)
      },
      showAnimation: {
        type: "fade",
        time: 300,
        callback: function() {}
      },
      hideAnimation: {
        type: "fade",
        time: 300,
        callback: function() {}
      },
    }
  }

  $input.easyAutocomplete(options)
});
