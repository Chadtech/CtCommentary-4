# Dependencies
Himesama = require 'himesama'
{ DOM }   = Himesama

# DOM
{ div, p, input } = DOM

row = -> 
  arguments[0] = className: 'row'
  div.apply @, arguments

column = ->
  arguments[0] = className: 'column'
  div.apply @, arguments

point = ->
  arguments[0] = className: 'point'
  div.apply @, arguments

module.exports = 
  row:    row
  column: column
  point:  point