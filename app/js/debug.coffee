debugThemes = require './debug-themes.coffee'

DEBUG = true

MESSAGE_TYPES = ['log', 'info', 'debug', 'warn', 'error']

getConsoleFunction = (type) ->
  switch type
    when 'log' then return console.log
    when 'info' then return console.info
    when 'debug' then return console.debug
    when 'warn' then return console.warn
    when 'error' then return console.error
    else return console.log

getOptionsFromTheme = (theme) ->
  switch theme
    when debugThemes.Player then return 'color:white; background:blue; display: block;'
    when debugThemes.Other then return 'color:white; background:grey; display: block;'
    else return null

module.exports = (message, type='log', theme=null, options=null) ->
  if not DEBUG
    return

  consoleFunction = getConsoleFunction type

  if theme? and theme in debugThemes.enums
    options = getOptionsFromTheme theme

  if options?
    consoleFunction "%c " + message, options
  else
    consoleFunction message
