CSSNano   = require('../src/index')
expect    = require('chai').expect
fs        = require 'fs'
path      = require 'path'

CSSNano.logger = {
  warn: (message) -> null # do nothing
}

describe 'CSSNano', ->

  cssnano = null

  beforeEach ->
    cssnano = new CSSNano(
      env: ['production']
      paths:
        public: path.join('test', 'public')
      optimize: true
    )

  it 'is an instance of CSSNano', ->
    expect(cssnano).to.be.instanceOf(CSSNano)

  it 'optimize', ->
    css = fs.readFileSync('test/fixtures/sample.css', 'utf-8')
    expected = fs.readFileSync('test/fixtures/sample.out.css', 'utf-8')
    cssnano.optimize {data: css}, (err, data) ->
      expect(data.data).to.be.eql(expected.replace(/\n/g, ''))

  it 'optimize with sourcemaps', ->
    css = fs.readFileSync('test/fixtures/sample.css', 'utf-8')
    map = {
      version: 3
      sources: [ 'sample.css' ]
      names: []
      mappings: 'AAAA,gBAQA,CARA,UACI,gBAA2B,CAC3B,SAAc,CACd,0BAA2B,CAC3B,kBAAmB,CAEnB,eAAmB,CACnB,qBACJ'
      file: 'sample.css'
    }
    cssnano.optimize {data: css, path: 'test/fixtures/sample.css'}, (err, data) ->
      expect(data.map).to.be.eql(map)
