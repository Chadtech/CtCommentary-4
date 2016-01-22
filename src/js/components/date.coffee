# Libraries
_        = require 'lodash'
Himesama = require '../himesama'
{ DOM }  = Himesama

# DOM
{ div, p, input } = DOM


module.exports = Title = Himesama.createClass
  
  needs: [ 'date' ]

  handle: (event) ->
    @setState date: event.target.value

  render: ->    

    input
      className: 'cell'
      value:     @state.date
      event:     input: @handle
