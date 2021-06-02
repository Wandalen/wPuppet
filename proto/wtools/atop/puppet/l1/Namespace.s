( function _Namespace_s_( )
{

'use strict';

const _ = _global_.wTools;
_.puppet = _.puppet || Object.create( null );
_.puppet.Strategies = _.puppet.Strategies || Object.create( null );

let vectorize = _.routineDefaults( null, _.vectorize, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let vectorizeAll = _.routineDefaults( null, _.vectorizeAll, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let vectorizeAny = _.routineDefaults( null, _.vectorizeAny, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } );
let vectorizeNone = _.routineDefaults( null, _.vectorizeNone, { vectorizingContainerAdapter : 1, unwrapingContainerAdapter : 0 } )

// --
// inter
// --

function systemDefaultGet()
{
  _.assert( arguments.length === 0 );

  if( _.puppet._defaultSystem )
  return _.puppet._defaultSystem;

  _.puppet._defaultSystem = _.puppet.System();
  _.puppet._defaultSystem.form();

  return _.puppet._defaultSystem;
}

//

function windowOpen( o )
{

  if( o === undefined )
  {
    o = Object.create( null );
  }

  var window = _.puppet.Window( o );

  return window.form();
}

//

function strategyAdd( Strategy )
{

  _.assert( _.prototype.isPrototypeFor( _.puppet.StrategyAbstract, Strategy ) );

  _.assert( _.puppet.Strategies[ Strategy.shortName ] === undefined );
  _.puppet.Strategies[ Strategy.shortName ] = Strategy;

  // let strategy = new Strategy;
  // _.assert( _.puppet.Strategies[ strategy.shortName ] === undefined );
  // _.puppet.strategies[ Strategy.shortName ] = strategy;

  return Strategy;
}

// --
// declare
// --

let Restricts =
{

  vectorize,
  vectorizeAll,
  vectorizeAny,
  vectorizeNone,

}

let Extension =
{

  _ : Restricts,

  systemDefaultGet,
  windowOpen,
  strategyAdd,

}

/* _.props.extend */Object.assign( _.puppet, Extension );

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

})();
