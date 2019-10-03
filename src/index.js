const cssnano = require('cssnano');

class CSSNanoOptimizer {
  static initClass() {
    this.prototype.brunchPlugin = true;
    this.prototype.type = 'stylesheet';
    this.prototype.extension = 'css';
    this.prototype.defaultEnv = '*';
  }

  constructor(config) {
    this.config = config;
    this.options = {
      // Write sourcemap
      sourcemap: true,
    };

    // Merge config
    const cfg = (this.config.plugins != null ? this.config.plugins.cssnano : undefined) != null ? (this.config.plugins != null ? this.config.plugins.cssnano : undefined) : {};
    for (let k in cfg) { this.options[k] = cfg[k]; }
  }

  compile(params, callback) {
    return callback(null, params);
  }

  optimize(params, callback) {
    const opts = {
      from: params.path,
      to:   params.path,
      map: {
        inline: false,
        annotation: false,
        sourcesContent: false
      }
    };

    if (params.map) {
      opts.map.prev = params.map.toJSON();
    }

    return cssnano.process(params.data, opts, this.options).then(result => callback(null, { data: result.css, map: result.map.toJSON() }));
  }
}
CSSNanoOptimizer.initClass();

module.exports = CSSNanoOptimizer;
