'use strict'

Utility   = require './'
should    = require 'should'
path      = require 'path'
fs        = require 'fs'
async     = require 'async'


describe 'Utility', ->

  describe 'create folder', ->

    after (done)->
      folder  = path.join 'test'
      Utility.removeFolder folder,->
        done()


    it 'create folder should not err', (done)->
      folder  = path.join 'test'
      Utility.createFolderIfExist folder,(err)->
        should.not.exist err
        (fs.existsSync(folder)).should.be.a.true;
        done()

    it 'create many folder', (done)->
      folder  = path.join 'test', 'test2', 'test3'
      Utility.createFolder folder, (err)->
        should.not.exist err
        (fs.existsSync(folder)).should.be.a.true;
        done()

    it 'remove folder', (done)->
      folder  = path.join 'test', 'test2', 'test3'
      async.series [
        (cb)->

          Utility.createFolder(folder, (err)->
            should.not.exist err
            cb null
          )

        (cb)->
          Utility.removeFolder(folder, (err)->
            should.not.exist err
            fs.existsSync(folder).should.be.false;
            cb null
          )
      ],->
        done()



  describe 'create string automatic', ->

    it 'create 3 string', ->
      Utility.randomString(3).should.length(3)

    it 'create 4 string', ->
      Utility.randomString(4).should.length(4)
