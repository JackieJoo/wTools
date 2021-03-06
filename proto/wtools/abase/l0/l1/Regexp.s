( function _l1_Regexp_s_()
{

'use strict';

const _global = _global_;
const _ = _global_.wTools;

_.assert( _.regexp === undefined );
_.regexp = Object.create( null );
_.assert( _.regexp.s === undefined );
_.regexp.s = Object.create( null );

// --
// regexp
// --

function is( src )
{
  return Object.prototype.toString.call( src ) === '[object RegExp]';
}

//

function objectIs( src )
{
  if( !_.RegexpObject )
  return false;
  return src instanceof _.RegexpObject;
}

//

function like( src )
{
  if( _.regexp.is( src ) || _.strIs( src ) )
  return true;
  return false;
}

// //
//
// function regexpsLike( srcs )
// {
//   if( !_.arrayIs( srcs ) )
//   return false;
//   for( let s = 0 ; s < srcs.length ; s++ )
//   if( !_.regexpLike( srcs[ s ] ) )
//   return false;
//   return true;
// }

//

function likeAll( src )
{
  _.assert( arguments.length === 1 );

  if( _.argumentsArray.like( src ) )
  {
    for( let s = 0 ; s < src.length ; s++ )
    if( !_.regexp.like( src[ s ] ) )
    return false;
    return true;
  }

  return _.regexp.like( src );
}

//

/**
 * Escapes special characters with a slash ( \ ). Supports next set of characters : .*+?^=! :${}()|[]/\
 *
 * @example
 * _.regexp.escape( 'Hello. How are you?' );
 * // returns "Hello\. How are you\?"
 *
 * @param {String} src Regexp string
 * @returns {String} Escaped string
 * @function escape
 * @namespace Tools
 */

function escape( src )
{
  _.assert( _.strIs( src ) );
  _.assert( arguments.length === 1, 'Expects single argument' );
  return src.replace( /([.*+?^=!:${}()|\[\]\/\\])/g, '\\$1' );
}

// --
// extension
// --

let ToolsExtension =
{

  regexpIs : is,
  regexpObjectIs : objectIs,
  regexpLike : like,
  regexpsLikeAll : likeAll,

  regexpEscape : escape,

}

Object.assign( _, ToolsExtension )

//

let RegexpExtension =
{

  // regexp

  is,
  objectIs,
  like,

  escape,

}

Object.assign( _.regexp, RegexpExtension )

//

let RegexpExtensions =
{

  // regexps

  likeAll,

}

Object.assign( _.regexp.s, RegexpExtensions )

})();
