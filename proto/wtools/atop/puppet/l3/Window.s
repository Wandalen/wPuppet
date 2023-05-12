( function _Window_s_( )
{

'use strict';

//

const _ = _global_.wTools;
const Parent = null;
const Self = wPuppetWindow;
function wPuppetWindow( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'Window';

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
  let window = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !window.logger )
  window.logger = new _.Logger({ output : _global_.logger });

  _.workpiece.initFields( window );
  Object.preventExtensions( window );

  if( o )
  window.copy( o );

  return window;
}

//

function unform()
{
  let window = this;

  if( !window.formed )
  return window;

  _.assert( arguments.length === 0 );
  _.assert( !!window.formed );

  let sys = window.system;
  let strategy = sys.strategy;

  return strategy.WindowUnform( window )
  .then( ( arg ) =>
  {
    window.formed = 0;
    return window;
  });
}

//

function form()
{
  let window = this;

  if( window.formed )
  return window;

  _.assert( arguments.length === 0 );
  _.assert( !window.formed );

  if( !window.system )
  window.system = _.puppet.systemDefaultGet();

  let sys = window.system;
  let strategy = sys.strategy;

  return strategy.WindowForm( window )
  .then( ( arg ) =>
  {
    window.formed = 1;
    return arg;
  });
}

//

function open()
{
  let window = this;
  _.assert( arguments.length === 0 );
  return window.form();
}

//

function close()
{
  let window = this;
  _.assert( arguments.length === 0 );
  return window.unform();
}

//

function pageOpen()
{
  let window = this;
  let sys = window.system;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  let page = new _.puppet.Page({ system : sys, window });
  return page.form();
}

// --
// relations
// --

let Composes =
{
  headless : 1,
  browser : null,
  dimensions : _.define.own([ 800, 600 ]),
  remoteConfig : null,
  args : _.define.own([]),
}

let Aggregates =
{
}

let Associates =
{
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
  open,
  close,

  pageOpen,

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
