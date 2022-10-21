( function _Strategy_s_( )
{

'use strict';

//

const _ = _global_.wTools;
const Parent = null;
const Self = wPuppetStrategyAbstract;
function wPuppetStrategyAbstract( o )
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
    logger.error( _.errOnce( err ) );
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
    logger.error( _.errOnce( err ) );
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
    logger.error( _.errOnce( err ) );
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

function PageEvalAsync( page, routine, ... args )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( _.strIs( routine ) || _.routineIs( routine ) );
    _.assert( arguments.length >= 2 );
    return this._PageEvalAsync( page, routine, ... args );
  })
}

//

function PageSelectEval( /* page, selector, routine, ... args */ ... args )
{
  let page = args[ 0 ];
  let selector = args[ 1 ];
  let routine = args[ 2 ];
  let args2 = args.slice( 3 );

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( _.strIs( routine ) || _.routineIs( routine ) );
    _.assert( arguments.length >= 3 );
    return this._PageSelectEval( page, selector, routine, ... args2 );
  })
}

//

function PageSelectFirstEval( /* page, selector, routine, ... args */ ... args )
{

  let page = args[ 0 ];
  let selector = args[ 1 ];
  let routine = args[ 2 ];
  let args2 = args.slice( 3 );

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( _.strIs( routine ) || _.routineIs( routine ) );
    _.assert( arguments.length >= 3 );
    return this._PageSelectFirstEval( page, selector, routine, ... args2 );
  })
}

//

function PageWaitForFunction( ... args )
{
  let page = args[ 0 ];
  let routine = args[ 1 ];
  let args2 = args.slice( 2 );

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( _.strIs( routine ) || _.routineIs( routine ) );
    _.assert( arguments.length >= 3 );
    return this._PageWaitForFunction( page, routine, ... args2 );
  })
}

//

function ElementScreenshot( ... args )
{
  let page = args[ 0 ];
  let selector = args[ 1 ];
  let path = args[ 2 ];

  return _.Consequence.Try( () =>
  {
    _.assert( _.str.is( selector ), 'Element selector should be a string, got: ', selector );
    _.assert( arguments.length >= 2 );

    if( path )
    path = _.path.nativize( path );

    return this._ElementScreenshot( page, selector, path );
  })
}

//

function MouseClick( ... args )
{
  let page = args[ 0 ];

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    return this._MouseClick( ... args );
  })
}

//

function MouseMove( ... args )
{
  let page = args[ 0 ];

  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    return this._MouseMove( ... args );
  })
}

//

function SessionDetailsGet( page )
{
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( arguments.length === 1 );

    return this._SessionDetailsGet( page );
  })
}

//

function SetViewport( ... args )
{
  let page = args[ 0 ];
  let sys = page.system;
  let window = page.window;
  let logger = sys.logger;

  return _.Consequence.Try( () =>
  {
    _.assert( arguments.length >= 1 );

    return this._SetViewport( ... args );
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
  _PageEvalAsync : null,
  PageEvalAsync,
  _PageSelectEval : null,
  PageSelectEval,
  _PageSelectFirstEval : null,
  PageSelectFirstEval,
  _PageWaitForFunction : null,
  PageWaitForFunction,
  _ElementScreenshot : null,
  ElementScreenshot,
  _MouseClick : null,
  MouseClick,
  _MouseMove : null,
  MouseMove,
  _SessionDetailsGet : null,
  SessionDetailsGet,
  _SetViewport : null,
  SetViewport,
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
  _PageEvalAsync : null,
  PageEvalAsync,
  _PageSelectEval : null,
  PageSelectEval,
  _PageSelectFirstEval : null,
  PageSelectFirstEval,
  _PageWaitForFunction : null,
  PageWaitForFunction,
  _ElementScreenshot : null,
  ElementScreenshot,
  _MouseClick : null,
  MouseClick,
  _MouseMove : null,
  MouseMove,
  _SessionDetailsGet : null,
  SessionDetailsGet,
  _SetViewport : null,
  SetViewport,
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

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
wTools.puppet[ Self.shortName ] = Self;

})();
