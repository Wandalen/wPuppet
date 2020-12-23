( function _Namespace_s_( )
{

'use strict';

let _ = _global_.wTools;
let Self = _.puppet;

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

_.mapExtend( Self, Extension );
_.puppet._metaSetup();

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = _global_.wTools;

})();
