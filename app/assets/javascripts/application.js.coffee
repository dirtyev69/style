#= require jquery
#= require jquery_ujs
#= require jquery.role
#= require role
#= require fotorama
#= require bootstrap
#= require nprogress/nprogress.js
#= require imagesloaded/imagesloaded.pkgd
#= require masonry/dist/masonry.pkgd

#= require fancybox/source/jquery.fancybox.pack
#= require fancybox/source/helpers/jquery.fancybox-thumbs

#= require underscore/underscore.js
#= require js-routes
#= require underscore.string/underscore.string.js
#= require jquery-autosize
#= require_tree ./ext
#= require_tree ./lib

$(document).ready ->
  window.Style = new Style($(document))

class Style
  constructor: (@$container) ->
    self = this

    new Lib.Gallery(@$container)
    new Lib.Fancybox(@$container)

    @$container.find('@fotorama').fotorama

    autosize(@$container.find('@autosize'))

    # @$container.find('@masonry')

    @$container.imagesLoaded ->
      $container.find('@masonry').masonry
