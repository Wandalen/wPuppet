( function _Page_s_( ) {

'use strict';

//

let _ = _global_.wTools;
let Parent = null;
let Self = function wPuppetPage( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Page';

// --
// inter
// --

function finit()
{
  if( this.formed )
  this.unform();
  return _.Copyable.prototype.finit.apply( this, arguments );
}

//

function init( o )
{
  let page = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !page.logger )
  page.logger = new _.Logger({ output : _global_.logger });

  _.workpiece.initFields( page );
  Object.preventExtensions( page );

  if( o )
  page.copy( o );

  return page;
}

//

function unform()
{
  let page = this;

  _.assert( arguments.length === 0 );
  _.assert( !!page.formed );

  page.formed = 0;
  return page;
}

//

function form()
{
  let page = this;
  let sys = page.system;
  let strategy = sys.strategy;

  if( page.formed )
  return page;

  _.assert( arguments.length === 0 );
  _.assert( !page.formed );
  _.assert( page.window instanceof _.puppet.Window );
  _.assert( page.system instanceof _.puppet.System );
  // _.assert( _.strDefined( page.pagePath ) );

  return strategy.PageForm( page )
  .then( ( arg ) =>
  {
    page.formed = 1;
    return page;
  });
}

//

function goto( pagePath )
{
  let page = this;
  let sys = page.system;
  let strategy = sys.strategy;

  _.assert( _.strDefined( pagePath ) );
  _.assert( arguments.length === 1 );
  _.assert( page.formed );

  page.pagePath = pagePath;

  return strategy.PageGoto( page, pagePath );
}

//

function select( selector )
{
  let page = this;
  let sys = page.system;
  let strategy = sys.strategy;
  _.assert( arguments.length === 1 );
  return strategy.PageSelect( page, selector );
}

//

function selectFirst( selector )
{
  let page = this;
  let sys = page.system;
  let strategy = sys.strategy;
  _.assert( arguments.length === 1 );
  return strategy.PageSelectFirst( page, selector );
}

//

function selectEval()
{
  let page = this;
  let sys = page.system;
  let strategy = sys.strategy;
  _.assert( arguments.length >= 2 );
  return strategy.PageSelectEval( page, ... arguments );
}

//

function selectFirstEval()
{
  let page = this;
  let sys = page.system;
  let strategy = sys.strategy;
  _.assert( arguments.length >= 2 );
  return strategy.PageSelectFirstEval( page, ... arguments );
}

//

function eval_()
{
  let page = this;
  let sys = page.system;
  let strategy = sys.strategy;
  _.assert( arguments.length >= 1 );
  return strategy.PageEval( page, ... arguments );
}

//

function _eventHandlerRegister( o )
{
  let page = this;
  let sys = page.system;
  let strategy = sys.strategy;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.routineIs( o.onHandle ) );

  let srcOnHandle = o.onHandle;
  o.onHandle = ( e ) => srcOnHandle.apply( srcOnHandle, e.args );
  _.EventHandler.prototype._eventHandlerRegister.call( page, o );
  return strategy.PageEventHandlerRegister( page, o.kind );
}

// --
// relations
// --

let Composes =
{
  pagePath : null,
}

let Aggregates =
{
}

let Associates =
{
  window : null,
  system : null,
}

let Restricts =
{
  formed : 0,
  _handle : null,
}

let Statics =
{
}

let Forbids =
{
  sys : 'sys',
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

  // inter

  finit,
  init,

  unform,
  form,

  goto,

  select,
  selectFirst,
  selectEval,
  selectFirstEval,
  eval : eval_,

  // event

  _eventHandlerRegister,

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

_.Copyable.mixin( Self );
_.EventHandler.mixin( Self );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
wTools.puppet[ Self.shortName ] = Self;

})();
