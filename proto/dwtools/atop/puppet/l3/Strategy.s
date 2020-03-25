( function _Strategy_s_( ) {

'use strict';

//

let _ = _global_.wTools;
let Parent = null;
let Self = function wPuppetStrategyAbstract( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'StrategyAbstract';

// --
// inter
// --

function WindowForm( window )
{
  let sys = window.system;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( !window._handle );
    _.assert( _.boolLike( window.headless ) );
    return this._WindowForm( window );
  })
  .then( ( handle ) =>
  {
    window._handle = handle;
    return window;
  })
  .catch( ( err ) =>
  {
    logger.log( _.errOnce( err ) );
    debugger;
    throw err;
  });
}

//

function WindowUnform( window )
{
  let sys = window.system;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( !!window._handle );
    return this._WindowUnform( window );
  })
  .then( ( arg ) =>
  {
    window._handle = null;
    return window;
  })
  .catch( ( err ) =>
  {
    logger.log( _.errOnce( err ) );
    debugger;
    throw err;
  });
}

//

function PageForm( page )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( !page._handle );
    // _.assert( _.strDefined( page.pagePath ) );
    return this._PageForm( page );
  })
  .then( ( handle ) =>
  {
    page._handle = handle;
    return page;
  })
  .catch( ( err ) =>
  {
    logger.log( _.errOnce( err ) );
    throw err;
  });
}

//

function PageGoto( page, pagePath )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( _.strDefined( pagePath ) );
    _.assert( arguments.length === 2 );
    return this._PageGoto( page, pagePath );
  })
}

//

function PageSelect( page, selector )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( _.strDefined( selector ) );
    _.assert( arguments.length === 2 );
    return this._PageSelect( page );
  })
}

//

function PageSelectFirst( page, selector )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( _.strDefined( selector ) );
    _.assert( arguments.length === 2 );
    return this._PageSelectFirst( page );
  })
}

//

function PageEval( page, routine, ... args )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( _.strIs( routine ) || _.routineIs( routine ) );
    _.assert( arguments.length >= 2 );
    return this._PageEval( page, routine, ... args );
  })
}

//

function PageSelectEval( page, selector, routine, ... args )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( _.strIs( routine ) || _.routineIs( routine ) );
    _.assert( arguments.length >= 3 );
    return this._PageSelectEval( page, selector, routine, ... args );
  })
}

//

function PageSelectFirstEval( page, selector, routine, ... args )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( _.strIs( routine ) || _.routineIs( routine ) );
    _.assert( arguments.length >= 3 );
    return this._PageSelectFirstEval( page, selector, routine, ... args );
  })
}

//

function PageEventHandlerRegister( page, kind )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( _.strIs( kind ) );
    _.assert( arguments.length === 2 );
    return this._PageEventHandlerRegister( page, kind );
  })
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

  _WindowForm : null,
  WindowForm,
  _WindowUnform : null,
  WindowUnform,

  _PageGoto : null,
  PageGoto,

  _PageForm : null,
  PageForm,

  _PageSelect : null,
  PageSelect,
  _PageSelectFirst : null,
  PageSelectFirst,

  _PageEval : null,
  PageEval,
  _PageSelectEval : null,
  PageSelectEval,
  _PageSelectFirstEval : null,
  PageSelectFirstEval,
  _PageEventHandlerRegister : null,
  PageEventHandlerRegister,
}

let Forbids =
{
}

// --
// declare
// --

let Proto =
{

  //

  _WindowForm : null,
  WindowForm,
  _WindowUnform : null,
  WindowUnform,

  _PageForm : null,
  PageForm,

  _PageGoto : null,
  PageGoto,

  _PageSelect : null,
  PageSelect,
  _PageSelectFirst : null,
  PageSelectFirst,

  _PageEval : null,
  PageEval,
  _PageSelectEval : null,
  PageSelectEval,
  _PageSelectFirstEval : null,
  PageSelectFirstEval,
  _PageEventHandlerRegister : null,
  PageEventHandlerRegister,

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

_.Copyable.mixin( Self );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
wTools.puppet[ Self.shortName ] = Self;

})();
