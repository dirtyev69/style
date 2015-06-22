namespace 'Lib'

class Lib.ImageUploader
  @filenameForBlob: (blob) ->
    "#{String.random()}.#{blob.type.split('/')[1]}"

  @upload: (options = {}) ->
    $.ajax(
      type: options.type || 'POST'
      dataType: options.dataType || 'html'
      url: options.url
      contentType: false
      processData: false
      cache: false
      data: options.data
    )


  constructor: (@options = {}) ->
    self = this

    @files = []
    @processed = []

    this.getInput().addEventListener('change'
      (event) ->
        NProgress.start() if NProgress?

        self.files = _.filter(this.files
          (file) ->
            !!file.type.match(/image.*/)
        )

        self.process(this.files)
        # self.trigger('change', this.files)
    )

  start: ->
    this.getInput().setAttribute('value', null)
    this.getInput().click()

  process: (files) ->
    self = this

    _.map(files
      (file) ->
        if window.FileReader
          reader = new FileReader()
          reader.onload =
            (e) ->
              image = new Image()
              image.src = reader.result

              image.onload =
                (e) ->
                  maxWidth = 2880
                  imageWidth = image.width
                  imageHeight = image.height

                  if (imageWidth > maxWidth)
                    imageHeight *= maxWidth / imageWidth
                    imageWidth = maxWidth

                    canvas = document.createElement('canvas')
                    canvas.width = imageWidth
                    canvas.height = imageHeight

                    ctx = canvas.getContext('2d')
                    ctx.clearRect(0, 0, canvas.width, canvas.height)
                    ctx.drawImage(image, 0, 0, canvas.width, canvas.height)

                    url = canvas.toDataURL(file.type)
                    file = self.convertToBlob(url)

                  self.addProcessed(file, url || image.src, imageWidth, imageHeight)

          reader.readAsDataURL(file)

        else
          self.addProcessed(file)
    )

  addProcessed: (file, src, width, height) ->
    @processed.push(file)

    this.trigger('processed', file, src, width, height)

    if @processed.length == @files.length
      this.trigger('processDone', @processed)

  convertToBlob: (dataURI) ->
    # convert base64/URLEncoded data component to raw binary data held in a string
    byteString = undefined

    byteString = if dataURI.split(",")[0].indexOf("base64") >= 0
      atob(dataURI.split(",")[1])
    else
      unescape(dataURI.split(",")[1])

    # separate out the mime component
    mimeString = dataURI.split(",")[0].split(":")[1].split(";")[0]

    # write the bytes of the string to a typed array
    ia = new Uint8Array(byteString.length)
    i = 0

    while i < byteString.length
      ia[i] = byteString.charCodeAt(i)
      i++

    new Blob([ia],
      type: mimeString
    )

  getInput: ->
    return @input if @input?

    @input = if @options['input']?
      @options['input']
    else
      node = document.createElement('input')
      node.setAttribute('type', 'file')
      node.setAttribute('accept', 'image/jpeg,image/png,image/gif')
      node.setAttribute('multiple', true) if @options['multiple'] == true
      node

extend Lib.ImageUploader, Lib.Events
