{CompositeDisposable} = require 'atom'

module.exports = AsciiArt =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ascii-art:convert': => @convert()

  deactivate: ->
    @subscriptions.dispose()

  convert: ->
    console.log 'Convert Text!'
    if editor = atom.workspace.getActiveTextEditor()
      #editor.insertText('Hello, World!')
      selection = editor.getSelectedText()

      figlet = require 'figlet'
      font = "Flower Power"
      figlet selection, {font: font}, (error, art) ->
        if error
          console.error(error)
          editor.insertText('Hello, Error!')
          editor.insertText(selection)
        else
          editor.insertText("\n#{art}\n")
          editor.insertText(selection)
