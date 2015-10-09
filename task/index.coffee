"use strict"

fs      = require 'fs'
cssnano = require 'cssnano'
postcss = require 'postcss'

class CSSNanoOptimizer
  brunchPlugin: true
  type: 'stylesheet'
  extension: 'css'

  constructor: (@config) ->
    @options = {
      pattern: /\.(?:css|scss|sass|less|styl)$/
      sourcemap: true
    }
    
    cfg = @config.plugins?.cssnano ? {}
    @options[k] = cfg[k] for k of cfg

  compile: (params, callback) ->
    callback null, params

  optimize: (params, callback) ->
    opts = {
      from: params.path,           
      to:   params.path,
      sourcemap: true          
    }
    console.log params
    try
      cssnano.process(params.data, opts).then (result) ->
        optimized result.css
    catch err
      error = err
    callback error, optimized

module.exports = CSSNanoOptimizer