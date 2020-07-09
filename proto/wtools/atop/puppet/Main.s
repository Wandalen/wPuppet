
/**
 * Browser puppet strategy.
  @module Tools/Puppet
*/

let _ = require( './include/Top.s' );
if( !module.parent )
_.puppet.Cui.Exec();
module[ 'exports' ] = _.puppet.Cui;
