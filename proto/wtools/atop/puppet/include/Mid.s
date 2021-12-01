( function _Mid_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  require( './Base.s' );

  require( '../l1/Namespace.s' );

  require( '../l3/Page.s' );
  require( '../l3/Strategy.s' );
  require( '../l3/System.s' );
  require( '../l3/Window.s' );

  require( '../l5_strategy/Puppeteer.s' );
  require( '../l5_strategy/WebDriverIO.s' );

  require( '../l9/Namespace.s' );

  module[ 'exports' ] = wTools;

}

})();
