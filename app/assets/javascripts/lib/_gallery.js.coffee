namespace 'Lib'

class Lib.Gallery
  constructor: (@$container) ->
    self = this

    @$container.find('@upload').on('click'
      (event) ->
        new Lib.ImageUploader({ multiple: true })
          .on('processDone'
            (files) ->
              for file, index in files
                data = new FormData()

                data.append('image[gallery_id]', self.getDataId())
                # data.append('partial', 'galleries/item')

                if file instanceof Blob
                  data.append("image[image]", file, Lib.ImageUploader.filenameForBlob(file))
                else
                  data.append("image[image]", file)

                Lib.ImageUploader.upload(
                  url: Routes.admin_images_path()
                  data: data
                ).done(
                  (html) ->
                    $item = self.$galleryItemsList().append(html)

                    # self.$galleryItemsList().imagesLoaded(
                    #   ->
                    #     self.$galleryItemsList().masonry('reloadItems').masonry('layout')
                    # )

                    NProgress.set(index / files.length)
                )

              NProgress.done()
              return false
          ).start()
    )

    # @$container.off('ajax:success', '@galleryItemRemoveLink').on('ajax:success', '@galleryItemRemoveLink'
    #   ->
    #     $(this).closest('@contentImage').remove()
    #     self.$galleryItemsList().masonry('reloadItems').masonry()
    # )

  $galleryItemsList: ->
    @$container.find('@galleryItemsList')

  getDataId: ->
    @$container.find('@galleryItemsList').data('id')

