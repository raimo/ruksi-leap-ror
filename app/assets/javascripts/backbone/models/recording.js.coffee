class RuksiLeapRor.Models.Recording extends Backbone.Model
  paramRoot: 'recording'

  defaults:
    title: null
    content: null

class RuksiLeapRor.Collections.RecordingsCollection extends Backbone.Collection
  model: RuksiLeapRor.Models.Recording
  url: '/recordings'
