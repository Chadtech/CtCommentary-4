# Dependencies
_        = require 'lodash'
Himesama = require './himesama'
{ DOM }  = Himesama

# DOM
{ div, p, input, br } = DOM
{ row, column, point } = require './components/ct-dom'

Title        = require './components/title'
PointSection = require './components/point-section'

module.exports = Main = Himesama.createClass

  needs: [ 'paragraphs' ]

  addPoint: ->
    paragraphs = @state.paragraphs
    paragraphs.push
      content: ''
      type:    'normal'
    @setState paragraphs: paragraphs


  render: ->

    div className: 'container',

      div className: 'row big',
        Title null

      row null, 
        div 
          style:
            height: '4em'

      _.map @state.paragraphs, (paragraph, i) =>

        PointSection (_.extend paragraph, i: i),
          ['yeeee']


      row null,
        input
          className: 'button add'
          type:      'submit'
          value:     '+'  
          event: click: @addPoint


