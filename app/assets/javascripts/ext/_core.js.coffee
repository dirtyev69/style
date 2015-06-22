window.namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block(target, top) if block?

window.extend = (target, source) ->
  for prop of source
    target::[prop] = source[prop]
  target

window.include = (klass, mixin) ->
  extend klass.prototype, mixin

String.random = (length = 8) ->
  chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz'.split('')

  str = new String
  length.times (i) ->
      str += chars[Math.floor(Math.random() * chars.length)]
  str

String.prototype.isBlank = ->
  this.length == 0 || !this.trim()

Number.prototype.times = (callback) ->
  for time in [1..@]
    callback time
Number.prototype.to = (max) ->
  arr = []
  for i in [(parseInt @)..max]
    arr.push i
  arr