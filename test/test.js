var Plugin = require("../task");
var fs = require('fs');
var should = require('should');

describe('Plugin', function () {

  var plugin, config;

  beforeEach(function() {
    config = {
      paths: {root: '.'},
      optimize: true
    };
    plugin = new Plugin(config);
  });

  it('should be an object', function() {
    plugin = new Plugin(config);
    plugin.should.be.ok;
  });

  it('optimize', function (done) {
    var css = fs.readFileSync('test/fixtures/sample.css', 'utf-8');
    var expected = fs.readFileSync('test/fixtures/sample.out.css', 'utf-8');
    plugin.optimize({data: css}, function (err, data) {
      data.data.should.be.eql(expected);
      done();
    });
  });

  it('optimize with sourcemaps', function (done) {
    var css = fs.readFileSync('test/fixtures/sample.css', 'utf-8');
    var map = {
      version: 3,
      sources: [ 'sample.css' ],
      names: [],
      mappings: 'AAKA,QACE,oBAAc,AAAd,qBAAc,AAAd,iBAAc,AAAd,oBAAc,AAAd,YAAc,CACf,AAPD,cACE,GACE,UAAY,CACb,AAMD,GACE,UAAY,CACb,CAPF',
      file: 'sample.css'
    };
    plugin.optimize({data: css, path: 'test/fixtures/sample.css'}, function (err, data) {
      data.map.should.be.eql(map);
      done();
    });
  });

});