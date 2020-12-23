( function _l3_Property_s_()
{

'use strict';

let _global = _global_;
let _ = _global_.wTools;
_global_.wTools.property = _global_.wTools.property || Object.create( null );

// --
// map checker
// --

function _ofAct( o )
{
  let result = Object.create( null );

  _.routineOptions( _ofAct, o );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !_.primitiveIs( o.srcMap ) );
  _.assert( this === _.property );

  let keys = _._mapKeys( o );

  for( let k = 0 ; k < keys.length ; k++ )
  {
    result[ keys[ k ] ] = o.srcMap[ keys[ k ] ];
  }

  return result;
}

_ofAct.defaults =
{
  srcMap : null,
  onlyOwn : 0,
  onlyEnumerable : 1,
  selectFilter : null,
}

//

/**
 * Routine property.of() gets onlyEnumerable properties of the object{-srcMap-} and returns them as new map.
 *
 * It takes an object {-srcMap-} creates an empty map,
 * checks if {-srcMap-} is an object.
 * If true, it copies unique onlyEnumerable properties of the provided object to the new map using
 * their original name/value and returns the result,
 * otherwise it returns empty map.
 *
 * @param { objectLike } srcMap - Object to get a map of onlyEnumerable properties.
 * @param { objectLike } o - routine options can be provided through routine`s context.
 * @param { boolean } [ o.onlyOwn = false ] - count only object`s onlyOwn properties.
 * @param { boolean } [ o.onlyEnumerable = true ] - count only object`s onlyEnumerable properties.
 *
 * @example
 * _.property.of( { a : 7, b : 13 } );
 * // returns { a : 7, b : 13 }
 *
 * @example
 * let a = { a : 1 };
 * let b = { b : 2 };
 * Object.setPrototypeOf( a, b );
 * _.property.of( a );
 * // returns { a : 1, b : 2 }
 *
 * @example
 * let a = { a : 1 };
 * let b = { b : 2 };
 * Object.setPrototypeOf( a, b );
 * _.property.of.call( { onlyOwn : 1 }, a )
 * // returns { a : 1 }
 *
 * @returns { object } A new map with unique onlyEnumerable properties from source{-srcMap-}.
 * @function of
 * @throws { Error } Will throw an Error if {-srcMap-} is not an objectLike entity.
 * @throws { Error } Will throw an Error if unknown option is provided.
 * @namespace Tools
 */

function _of( srcMap, o )
{

  _.assert( this === _.property );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  o = _.routineOptions( _of, o );

  o.srcMap = srcMap;

  let result = _.property._ofAct( o );
  return result;
}

_of.defaults =
{
  onlyOwn : 0,
  onlyEnumerable : 1,
}

//

/**
 * The own() gets the object's {-srcMap-} onlyOwn onlyEnumerable properties and returns them as new map.
 *
 * It takes an object {-srcMap-} creates an empty map,
 * checks if {-srcMap-} is an object.
 * If true, it copies object's onlyOwn onlyEnumerable properties to the new map using
 * their original name/value and returns the result,
 * otherwise it returns empty map.
 *
 * @param { objectLike } srcMap - Source to get a map of object`s onlyOwn onlyEnumerable properties.
 * @param { objectLike } o - routine options can be provided through routine`s context.
 * @param { boolean } [ o.onlyEnumerable = true ] - count only object`s onlyEnumerable properties.
 *
 * @example
 * _.property.own( { a : 7, b : 13 } );
 * // returns { a : 7, b : 13 }
 *
 * @example
 * let a = { a : 1 };
 * let b = { b : 2 };
 * Object.setPrototypeOf( a, b );
 * _.property.own( a );
 * // returns { a : 1 }
 *
 * @example
 * let a = { a : 1 };
 * Object.defineProperty( a, 'b', { onlyEnumerable : 0, value : 2 } );
 * _.property.own.call( { onlyEnumerable : 0 }, a )
 * // returns { a : 1, b : 2 }
 *
 * @returns { object } A new map with source {-srcMap-} onlyOwn onlyEnumerable properties.
 * @function own
 * @throws { Error } Will throw an Error if {-srcMap-} is not an objectLike entity.
 * @throws { Error } Will throw an Error if unknown option is provided.
 * @namespace Tools
 */

function own( srcMap, o )
{

  _.assert( this === _.property );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  o = _.routineOptions( own, o );

  o.srcMap = srcMap;
  o.onlyOwn = 1;

  let result = _.property._ofAct( o );
  return result;
}

own.defaults =
{
  onlyEnumerable : 1,
}

//

/**
 * The all() gets all properties from provided object {-srcMap-} and returns them as new map.
 *
 * It takes an object {-srcMap-} creates an empty map,
 * checks if {-srcMap-} is an object.
 * If true, it copies all unique object's properties to the new map using
 * their original name/value and returns the result,
 * otherwise it returns empty map.
 *
 * @param { objectLike } srcMap - Source to get a map of all object`s properties.
 *
 * @example
 * _.property.all( { a : 7, b : 13 } );
 * // returns { a : 7, b : 13, __defineGetter__ : function...}
 *
 * @example
 * let a = { a : 1 };
 * let b = { b : 2 };
 * Object.setPrototypeOf( a, b );
 * _.property.all( a );
 * // returns { a : 1, b : 2, __defineGetter__ : function...}
 *
 * @returns { object } A new map with all unique properties from source {-srcMap-}.
 * @function all
 * @throws { Error } Will throw an Error if {-srcMap-} is not an objectLike entity.
 * @throws { Error } Will throw an Error if unknown option is provided.
 * @namespace Tools
 */

function all( srcMap, o )
{

  _.assert( this === _.property );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  o = _.routineOptions( all, o );

  o.srcMap = srcMap;
  let result = _.property._ofAct( o );

  return result;
}

all.defaults =
{
  onlyOwn : 0,
  onlyEnumerable : 0,
}

//

/**
 * The routines() gets onlyEnumerable properties that contains routines as value from the object {-srcMap-} and returns them as new map.
 *
 * It takes an object {-srcMap-} creates an empty map,
 * checks if {-srcMap-} is an object.
 * If true, it copies unique onlyEnumerable properties that holds routines from source {-srcMap-} to the new map using
 * original name/value of the property and returns the result, otherwise it returns empty map.
 *
 * @param { objectLike } srcMap - Source to get a map of object`s properties.
 * @param { objectLike } o - routine options, can be provided through routine`s context.
 * @param { boolean } [ o.onlyOwn = false ] - count only object`s onlyOwn properties.
 * @param { boolean } [ o.onlyEnumerable = true ] - count only object`s onlyEnumerable properties.
 *
 * @example
 * _.property.routines( { a : 7, b : 13, f : function(){} } );
 * // returns { f : function(){} }
 *
 * @example
 * let a = { a : 1 };
 * let b = { b : 2, f : function(){} };
 * Object.setPrototypeOf( a, b );
 * _.property.routines( a )
 * // returns { f : function(){} }
 *
 * @example
 * let a = { a : 1 };
 * let b = { b : 2, f : function(){} };
 * Object.setPrototypeOf( a, b );
 * _.property.routines.call( { onlyOwn : 1 }, a )
 * // returns {}
 *
 * @returns { object } A new map with unique onlyEnumerable routine properties from source {-srcMap-}.
 * @function routines
 * @throws { Error } Will throw an Error if {-srcMap-} is not an objectLike entity.
 * @throws { Error } Will throw an Error if unknown option is provided.
 * @namespace Tools
 */


function routines( srcMap, o )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( this === _.property );
  o = _.routineOptions( routines, o );

  o.srcMap = srcMap;
  o.selectFilter = function selectRoutine( srcMap, k )
  {
    debugger;
    if( _.routineIs( srcMap[ k ] ) )
    return k;
    debugger;
  }

  debugger;
  let result = _.property._ofAct( o );
  return result;
}

routines.defaults =
{
  onlyOwn : 0,
  onlyEnumerable : 1,
}

//

/**
 * The ownRoutines() gets object`s {-srcMap-} onlyOwn onlyEnumerable properties that contains routines as value and returns them as new map.
 *
 * It takes an object {-srcMap-} creates an empty map,
 * checks if {-srcMap-} is an object.
 * If true, it copies object`s {-srcMap-} onlyOwn unique onlyEnumerable properties that holds routines to the new map using
 * original name/value of the property and returns the result, otherwise it returns empty map.
 *
 * @param { objectLike } srcMap - Source to get a map of object`s properties.
 * @param { objectLike } o - routine options, can be provided through routine`s context.
 * @param { boolean } [ o.onlyEnumerable = true ] - count only object`s onlyEnumerable properties.
 *
 * @example
 * _.property.ownRoutines( { a : 7, b : 13, f : function(){} } );
 * // returns { f : function(){} }
 *
 * @example
 * let a = { a : 1 };
 * let b = { b : 2, f : function(){} };
 * Object.setPrototypeOf( a, b );
 * _.property.ownRoutines( a )
 * // returns {}
 *
 * @example
 * let a = { a : 1 };
 * Object.defineProperty( a, 'b', { onlyEnumerable : 0, value : function(){} } );
 * _.property.ownRoutines.call( { onlyEnumerable : 0 }, a )
 * // returns { b : function(){} }
 *
 * @returns { object } A new map with unique object`s onlyOwn onlyEnumerable routine properties from source {-srcMap-}.
 * @function ownRoutines
 * @throws { Error } Will throw an Error if {-srcMap-} is not an objectLike entity.
 * @throws { Error } Will throw an Error if unknown option is provided.
 * @namespace Tools
 */

function ownRoutines( srcMap, o )
{

  _.assert( this === _.property );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  o = _.routineOptions( ownRoutines, o );

  o.srcMap = srcMap;
  o.onlyOwn = 1;
  o.selectFilter = function selectRoutine( srcMap, k )
  {
    debugger;
    if( _.routineIs( srcMap[ k ] ) )
    return k;
    debugger;
  }

  debugger;
  let result = _.property._ofAct( o );
  return result;
}

ownRoutines.defaults =
{
  onlyEnumerable : 1,
}

//

/**
 * The allRoutines() gets all properties of object {-srcMap-} that contains routines as value and returns them as new map.
 *
 * It takes an object {-srcMap-} creates an empty map,
 * checks if {-srcMap-} is an object.
 * If true, it copies all unique properties of source {-srcMap-} that holds routines to the new map using
 * original name/value of the property and returns the result, otherwise it returns empty map.
 *
 * @param { objectLike } srcMap - Source to get a map of object`s properties.
 *
 * @example
 * _.property.allRoutines( { a : 7, b : 13, f : function(){} } );
 * // returns { f : function, __defineGetter__ : function...}
 *
 * @example
 * let a = { a : 1 };
 * let b = { b : 2, f : function(){} };
 * Object.setPrototypeOf( a, b );
 * _.property.allRoutines( a )
 * // returns { f : function, __defineGetter__ : function...}
 *
 * @returns { object } A new map with all unique object`s {-srcMap-} properties that are routines.
 * @function allRoutines
 * @throws { Error } Will throw an Error if {-srcMap-} is not an objectLike entity.
 * @throws { Error } Will throw an Error if unknown option is provided.
 * @namespace Tools
 */

function allRoutines( srcMap, o )
{

  _.assert( this === _.property );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  o = _.routineOptions( allRoutines, o );

  o.srcMap = srcMap;
  o.onlyOwn = 0;
  o.onlyEnumerable = 0;
  o.selectFilter = function selectRoutine( srcMap, k )
  {
    debugger;
    if( _.routineIs( srcMap[ k ] ) )
    return k;
  }

  debugger;
  let result = _.property._ofAct( o );
  return result;
}

allRoutines.defaults =
{
}

//

/**
 * The fields() gets onlyEnumerable fields( all properties except routines ) of the object {-srcMap-} and returns them as new map.
 *
 * It takes an object {-srcMap-} creates an empty map,
 * checks if {-srcMap-} is an object.
 * If true, it copies unique onlyEnumerable properties of the provided object {-srcMap-} that are not routines to the new map using
 * their original name/value and returns the result, otherwise it returns empty map.
 *
 * @param { objectLike } srcMap - Object to get a map of onlyEnumerable properties.
 * @param { objectLike } o - routine options can be provided through routine`s context.
 * @param { boolean } [ o.onlyOwn = false ] - count only object`s onlyOwn properties.
 * @param { boolean } [ o.onlyEnumerable = true ] - count only object`s onlyEnumerable properties.
 *
 * @example
 * _.property.fields( { a : 7, b : 13, c : function(){} } );
 * // returns { a : 7, b : 13 }
 *
 * @example
 * let a = { a : 1 };
 * let b = { b : 2, c : function(){} };
 * Object.setPrototypeOf( a, b );
 * _.property.fields( a );
 * // returns { a : 1, b : 2 }
 *
 * @example
 * let a = { a : 1, x : function(){} };
 * let b = { b : 2 };
 * Object.setPrototypeOf( a, b );
 * _.property.fields.call( { onlyOwn : 1 }, a )
 * // returns { a : 1 }
 *
 * @returns { object } A new map with unique onlyEnumerable fields( all properties except routines ) from source {-srcMap-}.
 * @function fields
 * @throws { Error } Will throw an Error if {-srcMap-} is not an objectLike entity.
 * @throws { Error } Will throw an Error if unknown option is provided.
 * @namespace Tools
 */

function fields( srcMap, o )
{

  _.assert( this === _.property );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  o = _.routineOptions( fields, o );

  o.srcMap = srcMap;
  o.selectFilter = function selectRoutine( srcMap, k )
  {
    if( !_.routineIs( srcMap[ k ] ) )
    return k;
  }

  let result = _.property._ofAct( o );
  return result;
}

fields.defaults =
{
  onlyOwn : 0,
  onlyEnumerable : 1,
}

//

/**
 * The ownFields() gets object`s {-srcMap-} onlyOwn onlyEnumerable fields( all properties except routines ) and returns them as new map.
 *
 * It takes an object {-srcMap-} creates an empty map,
 * checks if {-srcMap-} is an object.
 * If true, it copies object`s onlyOwn onlyEnumerable properties that are not routines to the new map using
 * their original name/value and returns the result, otherwise it returns empty map.
 *
 * @param { objectLike } srcMap - Object to get a map of onlyEnumerable properties.
 * @param { objectLike } o - routine options can be provided through routine`s context.
 * @param { boolean } [ o.onlyEnumerable = true ] - count only object`s onlyEnumerable properties.
 *
 * @example
 * _.property.ownFields( { a : 7, b : 13, c : function(){} } );
 * // returns { a : 7, b : 13 }
 *
 * @example
 * let a = { a : 1 };
 * let b = { b : 2, c : function(){} };
 * Object.setPrototypeOf( a, b );
 * _.property.ownFields( a );
 * // returns { a : 1 }
 *
 * @example
 * let a = { a : 1, x : function(){} };
 * Object.defineProperty( a, 'b', { onlyEnumerable : 0, value : 2 } )
 * _.property.fields.call( { onlyEnumerable : 0 }, a )
 * // returns { a : 1, b : 2 }
 *
 * @returns { object } A new map with object`s {-srcMap-} onlyOwn onlyEnumerable fields( all properties except routines ).
 * @function ownFields
 * @throws { Error } Will throw an Error if {-srcMap-} is not an objectLike entity.
 * @throws { Error } Will throw an Error if unknown option is provided.
 * @namespace Tools
 */

function ownFields( srcMap, o )
{

  _.assert( this === _.property );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  o = _.routineOptions( ownFields, o );

  o.srcMap = srcMap;
  o.onlyOwn = 1;
  o.selectFilter = function selectRoutine( srcMap, k )
  {
    if( !_.routineIs( srcMap[ k ] ) )
    return k;
  }

  let result = _.property._ofAct( o );
  return result;
}

ownFields.defaults =
{
  onlyEnumerable : 1,
}

//

/**
 * The allFields() gets all object`s {-srcMap-} fields( properties except routines ) and returns them as new map.
 *
 * It takes an object {-srcMap-} creates an empty map,
 * checks if {-srcMap-} is an object.
 * If true, it copies all object`s properties that are not routines to the new map using
 * their original name/value and returns the result, otherwise it returns empty map.
 *
 * @param { objectLike } srcMap - Object to get a map of all properties.
 *
 * @example
 * _.property.allFields( { a : 7, b : 13, c : function(){} } );
 * // returns { a : 7, b : 13, __proto__ : Object }
 *
 * @example
 * let a = { a : 1 };
 * let b = { b : 2, c : function(){} };
 * Object.setPrototypeOf( a, b );
 * _.property.allFields( a );
 * // returns { a : 1, b : 2, __proto__ : Object }
 *
 * @example
 * let a = { a : 1, x : function(){} };
 * Object.defineProperty( a, 'b', { onlyEnumerable : 0, value : 2 } )
 * _.property.allFields( a );
 * // returns { a : 1, b : 2, __proto__ : Object }
 *
 * @returns { object } A new map with all fields( properties except routines ) from source {-srcMap-}.
 * @function allFields
 * @throws { Error } Will throw an Error if {-srcMap-} is not an objectLike entity.
 * @throws { Error } Will throw an Error if unknown option is provided.
 * @namespace Tools
 */

function allFields( srcMap, o )
{

  _.assert( this === _.property );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  o = _.routineOptions( allFields, o );

  o.srcMap = srcMap;
  o.onlyOwn = 0;
  o.onlyEnumerable = 0;
  o.selectFilter = function selectRoutine( srcMap, k )
  {
    if( !_.routineIs( srcMap[ k ] ) )
    return k;
  }

  if( _.routineIs( srcMap ) )
  o.selectFilter = function selectRoutine( srcMap, k )
  {
    if( _.longHas( [ 'arguments', 'caller' ], k ) )
    return;
    if( !_.routineIs( srcMap[ k ] ) )
    return k;
  }

  let result = _.property._ofAct( o );
  return result;
}

allFields.defaults =
{
}

// --
// extension
// --

let Extension =
{

  _ofAct,
  of : _of,
  own,
  all,

  routines,
  ownRoutines,
  allRoutines,

  fields,
  ownFields,
  allFields,

}

//

Object.assign( _.property, Extension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();