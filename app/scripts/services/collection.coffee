'use strict'

class Service
  items: []
  total: 0
  info: null
  collection: null

  constructor: (@$rootScope, @$http, @$location, @utils) ->

  get: (callback = ->) ->
    @$http.get('/v3/collection').then (result) =>
      @total = result.data.count
      @items = []
      for coll in result.data.rows
        @items.push
          title_en: coll.title_en
          link: "/hadith/#{coll.code}"
          code: coll.code
          first_book: @utils.firstBookId null, coll.code

      callback @
      @$rootScope.$broadcast('doneLoading', 'collection')

@app.service 'collectionService', ['$rootScope', '$http', '$location' , 'utils', Service]
