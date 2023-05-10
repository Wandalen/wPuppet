( function _Puppeteer_s_( )
{

'use strict';

let Puppeteer = require( 'puppeteer' );

//

const _ = _global_.wTools;
const Parent = _.puppet.StrategyAbstract;
const Self = wPuppetStrategyPuppeteer;
function wPuppetStrategyPuppeteer( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Puppeteer';

// --
// inter
// --

function _WindowForm( window )
{
  let sys = window.system;
  let logger = sys.logger;

  _.assert( _.longHas( [ null, 'chrome', 'firefox', 'browserstack' ], window.browser ) );

  const [ width, height ] = window.dimensions;

  if( window.browser === 'browserstack' )
  {
    _.assert( _.map.is( window.remoteConfig ) );
    let caps = encodeURIComponent( JSON.stringify( window.remoteConfig ) );
    let r = Puppeteer.connect
    ({
      browserWSEndpoint : `wss://cdp.browserstack.com/puppeteer?caps=${caps}`,
      defaultViewport : { width, height }
    });
    return r;
  }

  let o2 = Object.create( null );
  o2.headless = !!window.headless;
  o2.product = window.browser || 'chrome';
  o2.args = [ '--no-sandbox', '--enable-precise-memory-info', `--window-size=${ width },${ height }`, ... window.args ];
  o2.defaultViewport = { width, height };

  return Puppeteer.launch( o2 );
}

//

function _WindowUnform( window )
{
  let sys = window.system;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    return window._handle.pages();
  })
  .then( ( pages ) =>
  {
    return _.Consequence.And( ... pages.map( ( page ) => page.close() ) );
  })
  .then( () =>
  {
    let result = window._handle.close();
    if( result === undefined )
    result = null;
    return result;
  });
}

//

function _PageForm( page )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    return window._handle.newPage();
  })
  .then( ( handle ) =>
  {
    page._handle = handle;
    // return handle.goto( page.pagePath, { waitUntil : 'load' } )
    return page._handle;
  })
  // .then( ( handle ) =>
  // {
  //   return page._handle;
  // })

}

//

function _PageGoto( page, pagePath )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  page.pagePath = pagePath;

  return page._handle.goto( page.pagePath, { waitUntil : 'load' } )
}

//

function _PageSelect( page, selector )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  return page._handle.$( selector );
}

//

function _PageSelectFirst( page, selector )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  return page._handle.$$( selector );
}

//

function _PageEval( page, routine, ... args )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  return page._handle.evaluate( routine, ... args );
}

//

function _PageEvalAsync( page, routine, ... args )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  return page._handle.evaluate( routine, ... args );
}

//

function _PageSelectEval( /* page, selector, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let selector = args[ 1 ];
  let routine = args[ 2 ];
  let args2 = args.slice( 3 );

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  return page._handle.$$eval( selector, routine, ... args2 );
}

//

function _PageSelectFirstEval( /* page, selector, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let selector = args[ 1 ];
  let routine = args[ 2 ];
  let args2 = args.slice( 3 );

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  return page._handle.$eval( selector, routine, ... args2 );
}

//

function _PageWaitForFunction( /* page, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let routine = args[ 1 ];
  let args2 = args.slice( 2 );

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  return page._handle.waitForFunction( routine, ... args2 );
}

//

function _ElementScreenshot( /* page, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let selector = args[ 1 ];
  let path = args[ 2 ];

  return _.Consequence.From( page._handle.$( selector ) )
  .then( ( element ) =>
  {
    if( path )
    _.fileProvider.dirMakeForFile( path );

    return element.screenshot({ path });
  })
}

//

function _MouseClick( /* page, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let x = args[ 1 ];
  let y = args[ 2 ];

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.From( page._handle.mouse.click( x, y ) );
}

//

function _MouseMove( /* page, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let x = args[ 1 ];
  let y = args[ 2 ];

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.From( page._handle.mouse.move( x, y ) );
}

//

function _SessionDetailsGet( /* page, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let window = page.window;

  _.assert( window.browser === 'browserstack' );

  let arg = `browserstack_executor: ${ JSON.stringify( { action : 'getSessionDetails' } ) }`;
  return _.Consequence.From( page._handle.evaluate( () => {}, arg ) )
}

//

function _SetViewport( /* page, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let width = args[ 1 ];
  let height = args[ 2 ];

  return _.Consequence.From( page._handle.setViewport({ width, height }) )
}

//

function _PageEventHandlerRegister( page, kind )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  _.assert( Events[ kind ] !== undefined, `Event ${kind} support is not implemented` );

  return page._handle.on( kind, function( ... args )
  {
    page.eventGive({ kind, args })
  });
}

// --
// relations
// --

let Composes =
{
}

let Aggregates =
{
}

let Associates =
{
}

let Restricts =
{
}

let Statics =
{
  _WindowForm,
  _WindowUnform,
  _PageForm,
  _PageGoto,
  _PageSelect,
  _PageSelectFirst,
  _PageEval,
  _PageEvalAsync,
  _PageSelectEval,
  _PageSelectFirstEval,
  _PageWaitForFunction,
  _ElementScreenshot,
  _MouseClick,
  _MouseMove,
  _SessionDetailsGet,
  _SetViewport,
  _PageEventHandlerRegister
}

let Forbids =
{
}

let Events =
{
  console : 'console',
  requestfailed : 'requestfailed',
  pageerror : 'pageerror'
}

// --
// declare
// --

let Proto =
{

  _WindowForm,
  _WindowUnform,
  _PageForm,
  _PageGoto,
  _PageSelect,
  _PageSelectFirst,
  _PageEval,
  _PageEvalAsync,
  _PageSelectEval,
  _PageSelectFirstEval,
  _PageWaitForFunction,
  _ElementScreenshot,
  _MouseClick,
  _MouseMove,
  _SessionDetailsGet,
  _SetViewport,
  _PageEventHandlerRegister,

  // ident

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,
  Events

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

wTools.puppet.strategyAdd( Self );

})();
