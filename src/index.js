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
      // Autoprefixer
      autoprefixer: {add: false}
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
    
    for (let k in this.options) { opts[k] = this.options[k]; }
    
    if (params.map) {
      opts.map.prev = params.map.toJSON();
    }
    
    return cssnano.process(params.data, opts).then(result => callback(null, { data: result.css, map: result.map.toJSON() }));
  }
}
CSSNanoOptimizer.initClass();

module.exports = CSSNanoOptimizer;