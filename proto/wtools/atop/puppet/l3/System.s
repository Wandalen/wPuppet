( function _System_s_( )
{

'use strict';

//

const _ = _global_.wTools;
const Parent = null;
const Self = wPuppetSystem;
function wPuppetSystem( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'System';

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
  let sys = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( !sys.logger )
  sys.logger = new _.Logger({ output : _global_.logger });

  _.workpiece.initFields( sys );
  Object.preventExtensions( sys );

  if( o )
  sys.copy( o );

  sys.form();

  return sys;
}

//

function unform()
{
  let sys = this;

  _.assert( arguments.length === 0 );
  _.assert( !!sys.formed );

  /* begin */

  /* end */

  sys.formed = 0;
  return sys;
}

//

function form()
{
  let sys = this;

  if( sys.formed )
  return sys;

  sys.formAssociates();

  _.assert( arguments.length === 0 );
  _.assert( !sys.formed );

  sys.formed = 1;
  return sys;
}

//

function formAssociates()
{
  let sys = this;
  let logger = sys.logger;

  _.assert( arguments.length === 0 );
  _.assert( !sys.formed );

  if( !sys.logger )
  logger = sys.logger = new _.Logger({ output : _global_.logger });

  if( !sys.strategy )
  sys.strategy = 'Default';

  if( _.strIs( sys.strategy ) )
  {
    _.assert( !!_.puppet.Strategies[ sys.strategy ], `Unknown strategy ${sys.strategy}` );
    sys.strategy = _.puppet.Strategies[ sys.strategy ];
  }

  // _.assert( sys.strategy instanceof _.puppet.StrategyAbstract );
  _.assert( _.prototype.isPrototypeFor( _.puppet.StrategyAbstract, sys.strategy ) );

  return sys;
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
  logger : null,
  strategy : null,
}

let Restricts =
{
  formed : 0,
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
  formAssociates,

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
// _.Verbal.mixin( Self );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
wTools.puppet[ Self.shortName ] = Self;

})();
