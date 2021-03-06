Bookmarks = null
ReactBookmarks = null
BookmarksView = null
RegexDialog = null

module.exports =
  bookmarksNavigator: null

  activate: ->
    bookmarksView = null
    regexDialog = null

    atom.workspaceView.command 'bookmarks:use-regex', ->
      RegexDialog ?= require './regex-dialog'
      regexDialog = new RegexDialog()
      regexDialog.attach()

    atom.workspaceView.command 'bookmarks:toggle-navigator', =>
      @createNavigator().toggle()

    atom.workspaceView.command 'bookmarks:view-all', ->
      unless bookmarksList?
        BookmarksView ?= require './bookmarks-view'
        bookmarksView = new BookmarksView()
      bookmarksView.toggle()

    atom.workspaceView.eachEditorView (editorView) ->
      if editorView.attached and editorView.getPane()?
        if editorView.hasClass('react')
          ReactBookmarks ?= require './react-bookmarks'
          new ReactBookmarks(editorView)
        else
          Bookmarks ?= require './bookmarks'
          new Bookmarks(editorView)

  createNavigator: ->
    unless @bookmarksNavigator?
      BookmarksNavigator = require './bookmarks-navigator'
      @bookmarksNavigator = new BookmarksNavigator()
    @bookmarksNavigator
