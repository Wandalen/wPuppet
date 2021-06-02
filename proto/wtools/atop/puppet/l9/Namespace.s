( function _Namespace_s_( )
{

'use strict';

const _ = _global_.wTools;

// --
// inter
// --

function _metaSetup()
{
  if( !_.puppet.Strategies.Default )
  _.puppet.Strategies.Default = _.puppet.Strategies.Puppeteer;
  _.assert( !!_.puppet.Strategies.Default );
}

// --
// declare
// --

let Extension =
{

  _metaSetup,

}

/* _.props.extend */Object.assign( _.puppet, Extension );
_.puppet._metaSetup();

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

})();
