( function _Pupeteer_s_( ) {

'use strict';

let Pupeteer = require( 'puppeteer' );

//

let _ = _global_.wTools;
let Parent = _.puppet.StrategyAbstract;
let Self = function wPuppetStrategyPupeteer( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Pupeteer';

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

  return Pupeteer.launch( o2 );
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
    return handle.goto( page.pagePath, { waitUntil : 'load' } )
  })
  .then( ( handle ) =>
  {
    return page._handle;
  })

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
  _PageSelect,
  _PageSelectFirst,
  _PageEval,
  _PageSelectEval,
  _PageSelectFirstEval,
}

let Forbids =
{
}

// --
// declare
// --

let Proto =
{

  _WindowForm,
  _WindowUnform,
  _PageForm,
  _PageSelect,
  _PageSelectFirst,
  _PageEval,
  _PageSelectEval,
  _PageSelectFirstEval,

  // ident

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

wTools.puppet.strategyAdd( Self );

})();
