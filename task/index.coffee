"use strict"

cssnano = require 'cssnano'

class CSSNanoOptimizer
  brunchPlugin: true
  type: 'stylesheet'
  extension: 'css'
  defaultEnv: '*'

  constructor: (@config) ->
    @options = {
      # Write sourcemap
      sourcemap: true
      # Autoprefixer
      autoprefixer: {add: false}
    }
    
    # Merge config
    cfg = @config.plugins?.cssnano ? {}
    @options[k] = cfg[k] for k of cfg

  compile: (params, callback) ->
    callback(null, params)

  optimize: (params, callback) ->
    opts = {
      from: params.path           
      to:   params.path
      map: {
        inline: false
        annotation: false
        sourcesContent: false
      }
    }
    
    opts[k] = @options[k] for k of @options
    
    if params.map
      opts.map.prev = params.map.toJSON()
    
    cssnano.process(params.data, opts).then (result) ->
      callback(null, { data: result.css, map: result.map.toJSON() })

module.exports = CSSNanoOptimizer