"use strict"

fs      = require 'fs'
cssnano = require 'cssnano'


class CSSNanoOptimizer
  brunchPlugin: true

  constructor: (@config) ->
    @options = {
        type:'stylesheet'
        extension:'css'
        pattern: /\.(?:css|scss|sass|less|styl)$/
    }
    
    cfg = @config.plugins?.fingerprint ? {}
    @options[k] = cfg[k] for k of cfg

  compile: (params, callback) ->
    callback null, params

  optimize: (params, callback) ->
    opts = {
      from: params.path,           
      to:   params.path,
      sourcemap: true          
    }
    
    cssnano
      .process(params.data, opts)
      .then (result) ->
        fs.writeFileSync params.path, params.path

module.exports = CSSNanoOptimizer