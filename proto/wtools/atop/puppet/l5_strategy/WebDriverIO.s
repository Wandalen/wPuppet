( function _WebDriverIO_s_( )
{

'use strict';

let WebDriverIO = require( 'webdriverio' );

//

const _ = _global_.wTools;
const Parent = _.puppet.StrategyAbstract;
const Self = wPuppetStrategyWebDriverIO;
function wPuppetStrategyWebDriverIO( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'WebDriverIO';

// --
// inter
// --

function _WindowForm( window )
{
  let sys = window.system;
  let logger = sys.logger;

  _.assert( _.longHas( [ null, 'browserstack' ], window.browser ) );

  if( window.browser === 'browserstack' )
  {
    let o2 = Object.create( null );
    _.assert( _.map.is( window.remoteConfig ) );
    _.map.extend( o2, window.remoteConfig );

    return _.Consequence.Try( () => WebDriverIO.remote( o2 ) )
  }
}

//

function _WindowUnform( window )
{
  let sys = window.system;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    return window._handle.deleteSession();
  })
  .then( ( result ) =>
  {
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

  return Object.create( null );
}

//

function _PageGoto( page, pagePath )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  page.pagePath = pagePath;

  return _.Consequence.Try( () =>
  {
    return window._handle.url( page.pagePath );
  })

}

//

function _PageSelect( page, selector )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  return window._handle.$( selector );
}

//

function _PageSelectFirst( page, selector )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  return window._handle.$$( selector );
}

//

function _PageEval( page, routine, ... args )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  return window._handle.execute( routine, ... args );
}

//

function _PageEvalAsync( page, routine, ... args )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    return window._handle.setTimeout({ script : 60000 });
  })
  .then( () =>
  {
    return window._handle.executeAsync( routine, ... args );
  })

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

  _.assert( 0, 'not implemented' );

  // return page._handle.$$eval( selector, routine, ... args2 );
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

  _.assert( 0, 'not implemented' );

  // return page._handle.$eval( selector, routine, ... args2 );
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

  return _.Consequence.Try( () =>
  {
    return window._handle.waitUntil( async () =>
    {
      return window._handle.execute( routine );
    }, ... args2 );
  })
}

//

function _ElementScreenshot( /* page, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let selector = args[ 1 ];
  let path = args[ 2 ];

  let window = page.window;

  return _.Consequence.From( window._handle.$( selector ) )
  .then( ( element ) =>
  {
    if( path )
    _.fileProvider.dirMakeForFile( path );

    return element.saveScreenshot( path );
  })
}

//

function _MouseClick( /* page, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let element = args[ 1 ];
  let x = args[ 2 ];
  let y = args[ 3 ];

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.From( window._handle.$( element ) )
  .then( ( element ) =>
  {
    return element.click({ button : 0, x, y });
  })
}

//

function _MouseMove( /* page, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let element = args[ 1 ];
  let x = args[ 2 ];
  let y = args[ 3 ];

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.From( window._handle.$( element ) )
  .then( ( element ) =>
  {
    return element.moveTo({ x, y });
  });
}

//

function _SessionDetailsGet( /* page, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let window = page.window;
  _.assert( window.browser === 'browserstack' );
  return _.Consequence.From( window._handle.execute( `browserstack_executor: ${ JSON.stringify( { action : 'getSessionDetails' } ) }` ) );
}

//

function _SetViewport( /* page, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let window = page.window;
  let width = args[ 1 ];
  let height = args[ 2 ];

  return _.Consequence.From( window._handle.setWindowSize( width, height ) );
}

//

function _PageEventHandlerRegister( page, kind )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  _.assert( Events[ kind ] !== undefined, `Event ${kind} support is not implemented` );

  return null;

  // return page._handle.on( kind, function( ... args )
  // {
  //   page.eventGive({ kind, args })
  // });
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
