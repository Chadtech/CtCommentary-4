# Libraries
_        = require 'lodash'
Himesama = require 'himesama'
{ DOM }  = Himesama

# DOM
{ div, p, input } = DOM


module.exports = Title = Himesama.createClass
  
  needs: [ 'title' ]

  handle: (event) ->
    @setState title: event.target.value

  render: ->
    input
      className: 'cell big'
      value:     @state.title
      event:     input: @handle
