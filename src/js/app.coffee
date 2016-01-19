# Libraries
_                    = require 'lodash'
Himesama             = require 'himesama'
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
  paragraphs:     [ firstParagraph ]
  title:          ''

# Components
Main = require './main'


App = Himesama.createClass

  render: -> div null, Main()

Render App(), getElementById 'mount'

