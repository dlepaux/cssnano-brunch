const CSSNano    = require('../src/index');
const { expect } = require('chai');
const fs         = require('fs');
const path       = require('path');

CSSNano.logger = {
  warn(message) { return null; } // do nothing
};

describe('CSSNano', function() {

  let cssnano = null;

  beforeEach(() =>
    cssnano = new CSSNano({
      env: ['production'],
      paths: {
        public: path.join('test', 'public')
      },
      optimize: true
    })
  );

  it('is an instance of CSSNano', () => expect(cssnano).to.be.instanceOf(CSSNano));

  it('optimize', function() {
    const css = fs.readFileSync('test/fixtures/sample.css', 'utf-8');
    const expected = fs.readFileSync('test/fixtures/sample.out.css', 'utf-8');
    return cssnano.optimize({data: css}, (err, data) => expect(data.data).to.be.eql(expected.replace(/\n/g, '')));
  });

  return it('optimize with sourcemaps', function() {
    const css = fs.readFileSync('test/fixtures/sample.css', 'utf-8');
    const map = {
      version: 3,
      sources: [ 'sample.css' ],
      names: [],
      mappings: 'AAAA,gBAQA,CARA,UACI,gBAA2B,CAC3B,SAAc,CACd,0BAA2B,CAC3B,kBAAmB,CAEnB,eAAmB,CACnB,qBACJ',
      file: 'sample.css'
    };
    return cssnano.optimize({data: css, path: 'test/fixtures/sample.css'}, (err, data) => expect(data.map).to.be.eql(map));
  });
});
