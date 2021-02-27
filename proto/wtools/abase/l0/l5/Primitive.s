( function _l5_Primitive_s_()
{

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _.primitive = _.primitive || Object.create( null );

// --
// primitive
// --

function areIdenticalShallow( src1, src2 )
{
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.primitive.is( src1 ) );
  _.assert( _.primitive.is( src2 ) );

  return Object.is( src1, src2 );
}

//

function exportStringShortCode( src )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument' );
  _.assert( _.primitive.is( src ) );

  if( _.symbol.is( src ) )
  return _.symbol.exportStringShortCode( src );

  if( _.bigInt.is( src ) )
  return _.bigInt.exportStringShortCode( src );

  if( _.strIs( src ) )
  return `'${src}'`;

  return String( src );
}

//

function exportStringShortDiagnostic( src )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument' );
  _.assert( _.primitive.is( src ) );

  if( _.symbol.is( src ) )
  return _.symbol.exportStringShortDiagnostic( src );

  if( _.bigInt.is( src ) )
  return _.bigInt.exportStringShortDiagnostic( src );

  return String( src );
}

// --
// extension
// --

let ExtensionTools =
{

}

//

let Extension =
{
  areIdenticalShallow,

  exportString : exportStringShortDiagnostic,
  exportStringShort : exportStringShortDiagnostic,
  exportStringShortCode,
  exportStringShortDiagnostic,
  exportStringDiagnostic : exportStringShortDiagnostic,
  exportStringCode : exportStringShortCode,
}

Object.assign( _, ExtensionTools );
Object.assign( Self, Extension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
