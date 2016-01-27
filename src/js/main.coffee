# Dependencies
_        = require 'lodash'
Himesama = require './himesama'
{ DOM }  = Himesama
remote   = get 'remote'
fs       = get 'fs'
dialog   = remote.require 'dialog'

# DOM
{ div, p, input, br } = DOM
{ row, column, point } = require './components/ct-dom'

Title        = require './components/title'
Date         = require './components/date'
PointSection = require './components/point-section'

module.exports = Main = Himesama.createClass

  needs: [ 'paragraphs' ]

  addPoint: ->
    paragraphs = @state.paragraphs
    paragraphs.push
      content: ''
      type:    'normal'
    @setState paragraphs: paragraphs


  download: ->
    dialog.showSaveDialog (fn) =>

      Paper = _.reduce @state.paragraphs,
        (paper, paragraph) ->
          delimiter  = '|||'
          d = (paragraph.type.split '').shift()
          delimiter += d
          paper     += delimiter
          paper     += paragraph.content
        @state.title + '|||' + @state.date

      fs.writeFile fn, Paper


  open: ->
    dialog.showOpenDialog (fn) =>
      return unless fn?
      fn    = fn[0]
      fnExt = fn.slice (fn.length - 4)
      return unless fnExt is '.txt'
      txt     = fs.readFileSync fn, 'utf-8'
      txt     = txt.split '|||'
      title   = txt[0]
      date    = txt[1]
      content = txt.slice 2
      content = _.map content, (p_) ->
        content: p_.slice 1
        type:    p_[0]

      @setState 
        paragraphs: content
        title:      title
        date:       date


  render: ->

    div className: 'container',

      div className: 'row big',
        column null, 
          Title null
      div className: 'row big',
        column null,
          Date null

      row null, 
        div 
          style:
            height: '4em'

      _.map @state.paragraphs, (paragraph, i) =>

        PointSection (_.extend paragraph, i: i),
          ['yeeee']


      row null,

        input
          className:  'button add'
          type:       'submit'
          value:      '+'  
          event:      click: @addPoint

        input
          className:  'button add'
          type:       'submit'
          value:      'D'  
          event:      click: @download

        input
          className:  'button add'
          type:       'submit'
          value:      'O'  
          event:      click: @open
