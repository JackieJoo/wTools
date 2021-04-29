( function _l1_HashMap_s_()
{

'use strict';

const _global = _global_;
const _ = _global_.wTools;
_global_.wTools.hashMap = _global_.wTools.hashMap || Object.create( null );

// --
// dichotomy
// --

function is( src )
{
  if( !src )
  return false;
  return src instanceof HashMap || src instanceof HashMapWeak;
}

//

function like( src )
{
  return _.hashMap.is( src );
}

//

function isEmpty()
{
  if( !this.like( src ) )
  return false;
  return !src.size;
}

//

function isPopulated()
{
  if( !this.like( src ) )
  return false;
  return !!src.size;
}

// --
// maker
// --

function _makeEmpty( src )
{
  return new HashMap();
}

//

function makeEmpty( src )
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  if( arguments.length === 1 )
  _.assert( this.like( src ) );
  return new HashMap();
}

//

function _makeUndefined( src, length )
{
  return new HashMap();
}

//

function makeUndefined( src, length )
{
  _.assert( arguments.length === 0 || arguments.length === 1 || arguments.length === 2 );

  if( arguments.length === 2 )
  {
    _.assert( this.like( src ) );
    _.assert( _.number.is( length ) );
  }
  else if( arguments.length === 1 )
  {
    _.assert( _.number.is( src ) || this.like( src ) );
  }

  return new HashMap();
}

//

function _make( src, length )
{
  let result = new HashMap();
  if( src && length !== 0 )
  {
    if( _.hashMap.is( src ) )
    for( let [ key, val ] of src )
    result.set( key, val );
    else if( _.aux.is( src ) )
    for( let key of src )
    result.set( key, src[ key ] );
    else _.assert( 0 );
  }
  return result;
}

//

/* qqq : for junior : cover */
function make( src, length )
{
  _.assert( this.like( src ) );
  _.assert( arguments.length <= 2 );
  _.assert( arguments.length === 1 || _.hashMap.is( src ) || _.auxIs( src ) ); /* qqq : for junior : cover aux case */
  _.assert( arguments.length < 2 || length === 0 );
  return this._make( src, length );
}

//

function _cloneShallow( src )
{
  let result = new HashMap();
  for( let [ key, val ] of src )
  result.set( key, val );
  return result;
}

//

function cloneShallow( src )
{
  _.assert( this.like( src ) );
  _.assert( arguments.length === 1 );
  return this._cloneShallow( src );
}

//

function _empty( dst )
{
  dst.clear();
  return dst;
}

//

function empty( dst )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( this.like( dst ) );
  return this._empty( dst );
}

//

function fromProps( dstMap, srcMap )
{
  if( arguments.length === 1 )
  {
    srcMap = arguments[ 0 ];
    dstMap = null;
  }

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( !_.primitive.is( srcMap ) );
  _.assert( dstMap === null || _.hashMap.is( dstMap ) );

  if( dstMap === null )
  dstMap = new HashMap;

  for( let k in srcMap )
  {
    dstMap.set( k, srcMap[ k ] );
  }

  return dstMap;
}

//

function from( src )
{
  _.assert( arguments.length === 1 );
  if( this.is( src ) )
  return src;
  if( _.aux.is( src ) )
  return this.fromProps( null, src );
  _.assert( 0, `Not clear how to convert ${_.strType( src )} to HashMap` );
}

// --
// extension
// --

let ToolsExtension =
{

  // dichotomy

  hashMapIs : is.bind( _.hashMap ),
  hashMapIsEmpty : isEmpty.bind( _.hashMap ),
  hashMapIsPopulated : isPopulated.bind( _.hashMap ),
  hashMapLike : like.bind( _.hashMap ),

  // maker

  hashMapMakeEmpty : makeEmpty.bind( _.hashMap ),
  hashMapMakeUndefined : makeUndefined.bind( _.hashMap ),
  hashMapMake : make.bind( _.hashMap ),
  hashMapCloneShallow : cloneShallow.bind( _.hashMap ),
  hashMapFrom : from.bind( _.hashMap ),

}

Object.assign( _, ToolsExtension );

//

let Extension =
{

  //

  NamespaceName : 'hashMap',
  NamespaceQname : 'wTools/hashMap',
  TypeName : 'HashMap',
  SecondTypeName : 'Map',
  InstanceConstructor : HashMap,
  tools : _,

  // dichotomy

  is,
  like,
  isEmpty,
  isPopulated,

  /* xxx : qqq : implement keys* routines */

  // maker

  _makeEmpty,
  makeEmpty, /* qqq : for Yevhen : cover */
  _makeUndefined,
  makeUndefined, /* qqq : for Yevhen : cover */
  _make,
  make, /* qqq : for Yevhen : cover */
  _cloneShallow,
  cloneShallow, /* qqq : for Yevhen : cover */
  fromProps, /* qqq : for Yevhen : cover */
  from, /* qqq : for Yevhen : cover */

}

Object.assign( _.hashMap, Extension );

})();
