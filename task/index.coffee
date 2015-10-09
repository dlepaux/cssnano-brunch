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
      sourcemap: true
    }
    
    cfg = @config.plugins?.cssnano ? {}
    @options[k] = cfg[k] for k of cfg

  compile: (params, callback) ->
    callback null, params

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

    if params.map
      opts.map.prev = params.map.toJSON()

    postcss([cssnano()]).process(params.data, opts).then (result) ->
      fs.writeFileSync(params.path, result.css);
      fs.writeFileSync(params.path + '.map', result.map);

module.exports = CSSNanoOptimizer