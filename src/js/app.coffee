# Libraries
_                    = require 'lodash'
Himesama             = require './himesama'
{ DOM, Doc, Render } = Himesama
{ initState }        = Himesama
{ getElementById }   = Doc

# DOM
{ div } = DOM

# State
firstParagraph =
  content: ''
  type:    'normal'

initState 
  paragraphs: [ firstParagraph ]
  title:      ''
  date:       ''

# Components
Main = require './main'


App = Himesama.createClass

  render: -> 
    div null, 
      Main null

Render App(), getElementById 'mount'

