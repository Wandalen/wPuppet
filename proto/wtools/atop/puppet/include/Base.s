( function _Base_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../../wtools/Tools.s' );

  _.include( 'wProcess' );
  _.include( 'wCopyable' );
  _.include( 'wLogger' );
  _.include( 'wFiles' );

  // _.include( 'wTemplateTreeEnvironment' );
  //
  // _.include( 'wFiles' );
  // _.include( 'wFilesEncoders' );
  //
  // _.include( 'wStateStorage' );
  // _.include( 'wStateSession' );
  // _.include( 'wCommandsAggregator' );
  // _.include( 'wCommandsConfig' );
  // _.include( 'wNameMapper' );
  // _.include( 'wPersistent' );

  module[ 'exports' ] = wTools;

}

})();
