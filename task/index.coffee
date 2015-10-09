"use strict"

cssnano = require 'cssnano'
progeny = require 'progeny'

class CSSNanoOptimizer
  brunchPlugin: true
  type: 'stylesheet'
  extension: 'css'

  constructor: (@config) ->
    @options = {
      # Write sourcemap
      sourcemap: true
      # Make only safe postcss features
      safe: true
    }
    
    # Merge config
    cfg = @config.plugins?.fingerprint ? {}
    @options[k] = cfg[k] for k of cfg

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