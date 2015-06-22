namespace 'Lib'

class Lib.Fancybox
  constructor: (@$container) ->
    @$container.find('@fancybox').fancybox
      beforeLoad: -> @title = $(@element).attr('caption'); return;
      loop: false
      helpers:
        title:
          type: 'inside'
      minWidth: 400

    @$container.find('@fancyboxThumb').fancybox
      beforeLoad: -> @title = $(@element).attr('caption'); return;
      loop: false
      helpers:
        title:
          type: 'inside'
        thumbs:
          width: 60
          height: 60

    @$container.find('@fancyboxAjax').fancybox
      type: 'ajax'

    @$container.find('@fancyboxWork').fancybox
      loop: false
      type: 'ajax'
      arrows: false
      scrolling: 'no'
      fitToView: false
      maxWidth: 700