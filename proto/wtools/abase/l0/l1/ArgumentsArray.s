( function _l1_ArgumentsArray_s_()
{

'use strict';

const _global = _global_;
const _ = _global_.wTools;
_.argumentsArray = _.argumentsArray || Object.create( null );

// --
// dichotomy
// --

function is( src )
{
  return Object.prototype.toString.call( src ) === '[object Arguments]';
}

//

function like( src ) /* qqq : cover */
{
  if( _.argumentsArray.is( src ) )
  return true;
  if( _.array.is( src ) )
  return true;
  return false;
}

// --
// maker
// --

function _makeAct()
{
  return arguments;
}

//

function _make( src, length )
{
  if( arguments.length === 2 )
  {
    let data = length;
    if( _.number.is( length ) )
    data = src;
    if( _.countable.is( length ) )
    length = length.length;

    const dst = _.argumentsArray._makeAct.apply( _, _.number.is( length ) ? Array( length ) : [ ... length ] );
    return fill( dst, data );
  }
  else if( arguments.length === 1 )
  {
    if( _.numberIs( src ) )
    return _.argumentsArray._makeAct.apply( _, Array( src ) );
    if( _.long.is( src ) )
    return _.argumentsArray._makeAct.apply( _, [ ... src ] );
  }
  return _.argumentsArray._makeAct.apply( _, [] );

  /* */

  function fill( dst, data )
  {
    if( data === null || data === undefined )
    return dst;
    let l = Math.min( length, data.length );
    for( let i = 0 ; i < l ; i++ )
    dst[ i ] = data[ i ];
    return dst;
  }

  // if( src === undefined || src === null )
  // src = 0;
  // if( _.number.is( src ) )
  // return _.argumentsArray._makeAct.apply( _, Array( src ) );
  // else
  // return _.argumentsArray._makeAct.apply( _, src );
}

//

function make( src, length )
{
  _.assert( arguments.length === 0 || src === null || _.countable.is( src ) || _.numberIs( src ) );
  _.assert( length === undefined || !_.number.is( src ) || !_.number.is( length ) );
  _.assert( arguments.length < 2 || _.number.is( length ) || _.countable.is( length ) );
  _.assert( arguments.length <= 2 );
  return this._make( ... arguments );
  // _.assert( arguments.length === 0 || arguments.length === 1 );
  // _.assert( src === undefined || src === null || _.number.is( src ) || _.longLike( src ) );
  // return this._make( src );
}

//

function _makeEmpty()
{
  return this._make([]);
}

//

function makeEmpty()
{
  _.assert( arguments.length === 0 || arguments.length === 1 );
  _.assert( src === undefined || src === null || this.like( src ) );
  return this._makeEmpty();
}

//

function _makeUndefined( src, length )
{
  if( length === undefined )
  length = src;
  if( this.like( length ) )
  length = length.length;
  return this._make( length );
}

//

function makeUndefined( src, length )
{
  if( length === undefined )
  {
    length = src;
  }
  else
  {
    _.assert( this.like( src ) );
  }
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.number.is( length ) || this.like( length ) );
  return this.make( length );
}

//

function _makeFilling( type, value, length )
{
  if( arguments.length === 2 )
  {
    value = arguments[ 0 ];
    length = arguments[ 1 ];
    if( _.longIs( length ) )
    {
      if( _.argumentsArray.is( length ) )
      type = length;
      else if( _.number.is( length ) )
      type = null;
      else
      type = length;
    }
    else
    {
      type = null;
    }
  }

  if( _.longIs( length ) )
  length = length.length;

  let result = this._make( type, length );
  for( let i = 0 ; i < length ; i++ )
  result[ i ] = value;

  return result;
}

//

function makeFilling( type, value, length )
{
  _.assert( arguments.length === 2 || arguments.length === 3 );

  if( arguments.length === 2 )
  {
    _.assert( _.number.is( value ) || _.countable.is( value ) );
    _.assert( type !== undefined );
  }
  else
  {
    _.assert( value !== undefined );
    _.assert( _.number.is( length ) || _.countable.is( length ) );
    _.assert( type === null || _.routine.is( type ) || _.longIs( type ) );
  }

  return this._makeFilling( ... arguments );
}

//

function _cloneShallow( src )
{
  return this._makeAct( ... src );
}

//

function cloneShallow( src )
{
  _.assert( arguments.length === 1 );
  _.assert( this.like( src ) );
  return this._cloneShallow( src );
}

//

function from( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  if( this.is( src ) )
  return src;
  return this.make( src );
}

// --
// extension
// --

var ToolsExtension =
{

  // dichotomy

  argumentsArrayIs : is.bind( _.argumentsArray ),
  argumentsArrayLike : like.bind( _.argumentsArray ),

  // maker

  argumentsArrayMakeEmpty : makeEmpty.bind( _.argumentsArray ),
  argumentsArrayMakeUndefined : makeUndefined.bind( _.argumentsArray ),
  argumentsArrayMake : make.bind( _.argumentsArray ),
  argumentsArrayCloneShallow : cloneShallow.bind( _.argumentsArray ),
  argumentsArrayFrom : from.bind( _.argumentsArray ),

}

//

Object.assign( _, ToolsExtension );

//

var ArgumentsArrayExtension =
{

  //

  NamespaceName : 'argumentsArray',
  NamespaceQname : 'wTools/argumentsArray',
  TypeName : 'ArgumentsArray',
  SecondTypeName : 'Arguments',
  InstanceConstructor : null,
  tools : _,

  // dichotomy

  is,
  like,

  // maker

  _makeAct,
  _make,
  make, /* qqq : for junior : cover */
  _makeEmpty,
  makeEmpty, /* qqq : for junior : cover */
  _makeUndefined,
  makeUndefined, /* qqq : for junior : cover */
  _makeFilling,
  makeFilling,
  _cloneShallow,
  cloneShallow, /* qqq : for junior : cover */
  from, /* qqq : for junior : cover */

}

Object.assign( _.argumentsArray, ArgumentsArrayExtension );
_.long._namespaceRegister( _.argumentsArray );

})();
