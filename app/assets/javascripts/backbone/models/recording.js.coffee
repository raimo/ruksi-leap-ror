class RuksiLeapRor.Models.Recording extends Backbone.Model
  paramRoot: 'recording'

  defaults:
    title: null
    content: null

  isPlayable: ->
    content = @.get('content')
    return (_.isString(content) && content.length > 2)

class RuksiLeapRor.Collections.RecordingsCollection extends Backbone.Collection
  model: RuksiLeapRor.Models.Recording
  url: '/recordings'
