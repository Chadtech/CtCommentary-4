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

  moveUp: ->
    { i } = @attributes
    if i > 0
      thisP = @state.paragraphs[ i ]
      @state.paragraphs.splice i, 1
      @state.paragraphs.splice i - 1, 0, thisP
      @setState paragraphs: @state.paragraphs

  moveDown: ->
    { i } = @attributes
    if @state.paragraphs.length - 1 > i
      thisP = @state.paragraphs[ i ]
      @state.paragraphs.splice i, 1
      @state.paragraphs.splice i + 1, 0, thisP
      @setState paragraphs: @state.paragraphs

  setType: ->
    { i, content, type } = @attributes
    if type is 'normal' then type = 'logic'
    else type = 'normal'
    @state.paragraphs[i] = 
      content: content
      type:    type

    @setState paragraphs: @state.paragraphs

  remove: ->
    { i, content, type } = @attributes
    @state.paragraphs.splice i, 1
    @setState paragraphs: @state.paragraphs

  render: ->
    { content, active, i, type } = @attributes

    buttonValue = 'E'
    buttonValue = 'S' if active

    buttonAction = @setToEdit
    buttonAction = @setToSave if active

    classAd = ''
    classAd += ' logic' if type isnt 'normal'

    C = 
      if active
        textarea
          className: 'point-section' + classAd
          event:     input: @handle
          content

      else
        _.flatten _.map (content.split '\n\n'), 
          (paragraph, j) ->
            if j is 0
              paragraph = 'nothing .. ' unless paragraph
              paragraph = '* ' + i + ' ' + paragraph

            cl = 'point' + classAd

            [
              p className: cl, paragraph
              br null
            ]

    row null,
      div className: 'column',

        div
          style: 
            marginLeft:   '2em'
            width:        '90%'
            marginRight:  '0'

          C

        div className: 'buttons-container',

          input
            className: 'button edit'
            type:      'submit'
            value:     buttonValue
            event:     click: buttonAction

          input
            className: 'button edit'
            type:      'submit'
            value:     '^'
            event:     click: @moveUp

          input
            className: 'button edit'
            type:      'submit'
            value:     'v'
            event:     click: @moveDown

          input
            className: 'button edit'
            type:      'submit'
            value:     'T'
            event:     click: @setType

          input
            className: 'button edit remove'
            type:      'submit'
            value:     'X'
            event:     click: @remove




