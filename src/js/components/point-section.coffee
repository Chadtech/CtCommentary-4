# Libraries
_        = require 'lodash'
Himesama = require '../himesama'
{ DOM }  = Himesama

# DOM
{ div, input, textarea, p, br } = DOM
{ row, column, point } = require './ct-dom'



module.exports = PointSection = Himesama.createClass

  initAttr: -> active: true

  handle: (event) ->
    @setAttr content: event.target.value

  setToEdit: ->
    @setAttr active: true

  setToSave: ->
    { i, content, type } = @attributes
    @setAttr active: false
    paragraphs    = @state.paragraphs
    paragraphs[i] = 
      content: content
      type:    type
    @setState paragraphs: paragraphs

  render: ->
    { content, active, i } = @attributes

    buttonValue = 'E'
    buttonValue = 'S' if active

    buttonAction = @setToEdit
    buttonAction = @setToSave if active

    C = 
      if active
        textarea
          className: 'point-section'
          event:     input: @handle
          content

      else
        _.flatten _.map (content.split '\n\n'), 
          (paragraph, j) ->
            if j is 0
              paragraph = 'nothing .. ' unless paragraph
              paragraph = '* ' + i + ' ' + paragraph

            [
              p className: 'point', paragraph
              br null
            ]

    row null,
      div className: 'column',

        div
          style: 
            marginLeft: '2em'
            width:      '90%'

          C
        
        input
          className: 'button edit'
          type:      'submit'
          value:     buttonValue
          event:     click: buttonAction




