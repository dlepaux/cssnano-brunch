"use strict"

fs      = require 'fs'
cssnano = require 'cssnano'
postcss = require 'postcss'

warn = (message) -> CSSNano.logger.warn "cssnano-brunch WARNING: #{message}"

class CSSNano
  brunchPlugin: true
  type: 'stylesheet'
  extension: 'css'

  constructor: (@config) ->
    @options = {
      pattern: /\.(?:css|scss|sass|less|styl)$/
      sourcemap: true
    }
    warn 'Hello World'
    cfg = @config.plugins?.cssnano ? {}
    @options[k] = cfg[k] for k of cfg

  #compile: (params, callback) ->
  #  console.log 'tata'
    

  optimize: (params, callback) ->
    console.log 'error'
    #opts = {
    #  from: params.path,           
    #  to:   params.path,
    #  sourcemap: true          
    #}
    #console.log params
    #try
    #  cssnano.process(params.data, opts).then (result) ->
    #    optimized result.css
    #catch err
    #  error = err
    #callback error, optimized

CSSNano.logger = console
module.exports = CSSNano
