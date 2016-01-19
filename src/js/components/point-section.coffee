# Libraries
_        = require 'lodash'
Himesama = require 'himesama'
{ DOM }  = Himesama

# DOM
{ div, input, textarea, p, br } = DOM


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

  saveOrEdit: -> 
    { active } = @attributes
    @setAttr active: not active

  render: ->
    { content, active, i } = @attributes

    buttonValue = 'E'
    buttonValue = 'S' if active

    buttonAction = @setToEdit
    buttonAction = @setToSave if active

    representationOfContent = 
      if active
        textarea
          className: 'point-section'
          event:     input: @handle
          content

      else
        _.map (content.split '\n\n'), (paragraph, j) ->
          if j is 0
            paragraph = 'nothing.. ' unless paragraph
            paragraph = '* ' + i + ' ' + paragraph

          div null,
            p className: 'point', paragraph
            br null

    div 
      style:
        position:   'relative'
        marginLeft: '4em'
      
      div 
        style:
          width:      '90%'

        representationOfContent

      input
        className: 'button edit'
        type:      'submit'
        value:     buttonValue
        event:     click: buttonAction




