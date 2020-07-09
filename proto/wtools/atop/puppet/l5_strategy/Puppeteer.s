( function _Puppeteer_s_( ) {

'use strict';

let Puppeteer = require( 'puppeteer' );

//

let _ = _global_.wTools;
let Parent = _.puppet.StrategyAbstract;
let Self = wPuppetStrategyPuppeteer;
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

  _.assert( _.longHas( [ null, 'chrome', 'firefox' ], window.browser ) );

  let o2 = Object.create( null );
  o2.headless = !!window.headless;
  o2.product  = window.browser || 'chrome';

  return Puppeteer.launch( o2 );
}

//

function _WindowUnform( window )
{
  let sys = window.system;
  let logger = sys.logger;
  let result = window._handle.close();
  if( result === undefined )
  result = null;
  return result;
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

function _PageSelectEval( page, selector, routine, ... args )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  return page._handle.$$eval( selector, routine, ... args );
}

//

function _PageSelectFirstEval( page, selector, routine, ... args )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;
  debugger;
  return page._handle.$eval( selector, routine, ... args );
}

//

function _PageEventHandlerRegister( page, kind )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  _.assert( Events[ kind ] !== undefined, `Event ${kind} support is not implemented` );

  return page._handle.on( kind, function( ...args )
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
  _PageSelectEval,
  _PageSelectFirstEval,
  _PageEventHandlerRegister
}

let Forbids =
{
}

let Events =
{
  console : 'console'
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
  _PageSelectEval,
  _PageSelectFirstEval,
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
