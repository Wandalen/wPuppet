
/**
 * Browser puppet strategy.
  @module Tools/Puppet
*/

const _ = require( './include/Top.s' );
if( !module.parent )
_.puppet.Cui.Exec();
module[ 'exports' ] = _.puppet.Cui;
