( function _Ext_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  var Puppeteer = require( 'puppeteer' );
  var _ = require( '../../Tools.s' );
  _.include( 'wTesting' );
  // _.include( 'wStarter' );
  require( '../puppet/Include.s' );

}

var _global = _global_;
var _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;

  self.suiteTempPath = _.path.pathDirTempOpen( _.path.join( __dirname, '../..'  ), 'Puppet' );
  self.assetsOriginalSuitePath = _.path.join( __dirname, '_assets' );

  // self.suiteTempPath = path.pathDirTempOpen( path.join( __dirname, '../..'  ), 'err' );
  // self.assetsOriginalSuitePath = path.join( __dirname, '_assets' );

  // self.find = _.fileProvider.filesFinder
  // ({
  //   withTerminals : 1,
  //   withDirs : 1,
  //   withTransient : 1,
  //   allowingMissed : 1,
  //   maskPreset : 0,
  //   outputFormat : 'relative',
  //   filter :
  //   {
  //     filePath : { 'node_modules' : 0, 'package.json' : 0, 'package-lock.json' : 0 },
  //     recursive : 2,
  //   }
  // });

}

//

function onSuiteEnd()
{
  let self = this;
  _.fileProvider.filesDelete( self.suiteTempPath );
}

// --
// tests
// --

async function basic( test )
{
  let self = this;
  let a = test.assetFor();
  var page, window;

  a.reflect();

  try
  {
    window = await _.puppet.windowOpen({ headless : true });
    page = await window.pageOpen();

    await page.goto( _.path.nativize( a.abs( 'Index.html' ) ) );

    var exp = [ `file:///${_.path.nativize( a.abs( 'Index.js' ) )}`.replace( /\\/g, '/' ), `` ]
    var got = await page.selectEval( 'script', ( scripts ) => scripts.map( ( s ) => s.src ) );
    test.identical( got, exp );

    var got = await page.eval( () =>
    {
      var style = window.getComputedStyle( document.querySelector( 'body' ) );
      return style.getPropertyValue( 'background' )
    });
    test.is( _.strHas( got, 'rgb(173, 216, 230)' ) );

    await window.close();
  }
  catch( err )
  {
    test.exceptionReport({ err });
    await window.close();
  }

}

//

async function puppeteerRaw( test )
{
  let self = this;
  let a = test.assetFor();
  var page, window;

  a.reflect();

  try
  {
    window = await Puppeteer.launch({ headless : true });
    page = await window.newPage();

    await page.goto( _.path.nativize( a.abs( 'Index.html' ) ), { waitUntil : 'load' } );

    var exp = [ `file:///${_.path.nativize( a.abs( 'Index.js' ) )}`.replace( /\\/g, '/' ), `` ]
    var got = await page.$$eval( 'script', ( scripts ) => scripts.map( ( s ) => s.src ) );
    test.identical( got, exp );

    var got = await page.evaluate( () =>
    {
      var style = window.getComputedStyle( document.querySelector( 'body' ) );
      return style.getPropertyValue( 'background' )
    });
    test.is( _.strHas( got, 'rgb(173, 216, 230)' ) );

    await window.close();
  }
  catch( err )
  {
    test.exceptionReport({ err });
    await window.close();
  }

}

// --
// declare
// --

var Self =
{

  name : 'Puppet.Ext',
  silencing : 1,
  enabled : 1,
  routineTimeOut : 60000,
  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    suiteTempPath : null,
    assetsOriginalSuitePath : null,
    execJsPath : null,
  },

  tests :
  {

    basic,
    puppeteerRaw,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
