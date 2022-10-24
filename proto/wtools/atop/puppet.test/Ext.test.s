( function _Ext_test_s_()
{

'use strict';

var Puppeteer;
if( typeof module !== 'undefined' )
{

  Puppeteer = require( 'puppeteer' );
  const _ = require( '../../../node_modules/Tools' );
  _.include( 'wTesting' );
  // _.include( 'wStarter' );
  require( '../puppet/Include.s' );

}

const _global = _global_;
const _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;

  self.suiteTempPath = _.path.tempOpen( _.path.join( __dirname, '../..' ), 'Puppet' );
  self.assetsOriginalPath = _.path.join( __dirname, '_assets' );

  // self.suiteTempPath = path.tempOpen( path.join( __dirname, '../..'  ), 'err' );
  // self.assetsOriginalPath = path.join( __dirname, '_assets' );

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

    await page.goto( `file://${_.path.nativize( a.abs( 'Index.html' ) )}` );

    var exp = [ `file://${process.platform === 'win32' ? '/' : '' }${_.path.nativize( a.abs( 'Index.js' ) )}`.replace( /\\/g, '/' ), `` ]
    var got = await page.selectEval( 'script', ( scripts ) => scripts.map( ( s ) => s.src ) );
    test.identical( got, exp );

    var got = await page.eval( () =>
    {
      var style = window.getComputedStyle( document.querySelector( 'body' ) );
      return style.getPropertyValue( 'background' )
    });
    test.true( _.strHas( got, 'rgb(173, 216, 230)' ) );

    await window.close();
  }
  catch( err )
  {
    test.exceptionReport({ err });
    await window.close();
  }
}

//

async function onConsole( test )
{
  let self = this;
  let a = test.assetFor( 'basic');
  var page, window;

  a.reflect();

  try
  {
    window = await _.puppet.windowOpen({ headless : true });
    page = await window.pageOpen();

    let output = '';

    await page.on( 'console', ( msg ) =>
    {
      output += msg.text();
    })

    await page.goto( `file://${_.path.nativize( a.abs( 'Index.html' ) )}` );

    await page.eval( () =>
    {
      console.log( 'Hello world' );
    });

    test.true( _.strHas( output, 'Hello world' ) );

    await window.close();
  }
  catch( err )
  {
    test.exceptionReport({ err });
    await window.close();
  }
}

//

async function elementScreenshotTrivial( test )
{
  const self = this;
  const a = test.assetFor();
  let window;

  a.reflect();

  try
  {
    window = await _.puppet.windowOpen({ headless : true });
    const page = await window.pageOpen();

    await page.goto( `file://${_.path.nativize( a.abs( 'Index.html' ) )}` );

    test.case = 'no path';
    await page.elementScreenshot( '.test' );
    var files = a.fileProvider.dirRead( a.abs( '.' ) );
    test.identical( files, [ 'Index.html' ] );

    test.case = 'with path';
    await page.elementScreenshot( '.test', a.abs( 'canvas.png' ) );
    var files = a.fileProvider.dirRead( a.abs( '.' ) );
    test.identical( files, [ 'canvas.png', 'Index.html' ] );

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

    await page.goto( `file://${_.path.nativize( a.abs( 'Index.html' ) )}`, { waitUntil : 'load' } );

    var exp = [ `file://${process.platform === 'win32' ? '/' : '' }${_.path.nativize( a.abs( 'Index.js' ) )}`.replace( /\\/g, '/' ), `` ]
    var got = await page.$$eval( 'script', ( scripts ) => scripts.map( ( s ) => s.src ) );
    test.identical( got, exp );

    var got = await page.evaluate( () =>
    {
      var style = window.getComputedStyle( document.querySelector( 'body' ) );
      return style.getPropertyValue( 'background' )
    });
    test.true( _.strHas( got, 'rgb(173, 216, 230)' ) );

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

const Proto =
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
    assetsOriginalPath : null,
    appJsPath : null,
  },

  tests :
  {
    basic,
    onConsole,
    elementScreenshotTrivial,
    puppeteerRaw,
  }
};

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
