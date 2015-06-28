namespace 'Lib'

class Lib.Up
  constructor: (@$container) ->
    self = this

    return unless @$container.length > 0
    offset_up = @$container.offset()
    offset_up_top = offset_up.top + 400

    fixing_window_scroll = ->
      if $(window).scrollTop() > offset_up_top
        $("@up").addClass "fixed"
      else
        $("@up").removeClass "fixed"

    $(window).scroll _.throttle(fixing_window_scroll, 100)

    @$container.off("click").on("click", ->
        $("html, body").animate
          scrollTop: 0
        , 250
        false
      )

