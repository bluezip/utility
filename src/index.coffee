'use strict'
async   = require "async"
fs      = require 'fs'
child   = require 'child_process'


class utility

  constructor : ->


  # create folder if not found
  @createFolderIfExist: (path, callback) ->

    unless fs.existsSync(path)
      fs.mkdir path, (err) ->
        return callback(err)  if err
        callback null

    else
      callback null

  @createFolder: (folder, callback)->
    folder    = folder.replace(/\\/, "/")
    director  = folder.split("/")
    dir       = []
    director.forEach (v, i) ->
      dir.push v
      _path   = dir.join("/")
      utility.createFolderIfExist _path, (err) ->
        return callback(err)  if err
        callback null  if i is (director.length - 1)


  @removeFolder: (directories, callback) ->
    directories = [directories]  if typeof directories is "string"
    args = directories
    args.unshift "-rf"
    child.execFile "rm", args,
      env: process.env
    , (err, stdout, stderr) ->
      callback.apply this, arguments
      return






  @randomString : (length) ->
    result = ""
    chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    i = length

    while i > 0
      result += chars[Math.round(Math.random() * (chars.length - 1))]
      --i
    result

module.exports  = utility
