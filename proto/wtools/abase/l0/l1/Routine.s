( function _l1_Routine_s_()
{

'use strict';

const _global = _global_;
const _ = _global_.wTools;
const Self = _global_.wTools;
let Routine = _global_.wTools.routine = _global_.wTools.routine || Object.create( null );
let RoutineS = _global_.wTools.routine.s = _global_.wTools.routine.s || Object.create( null );
/* qqq : for Yevhen : bad : remove vars */

// --
// routine
// --

function __mapButKeys( srcMap, butMap )
{
  let result = [];

  for( let s in srcMap )
  if( !( s in butMap ) )
  result.push( s );

  return result;
}

//

function __mapUndefinedKeys( srcMap )
{
  let result = [];

  for( let s in srcMap )
  if( srcMap[ s ] === undefined )
  result.push( s );

  return result;
}

//

function __keysQuote( keys )
{
  let result = `"${ keys[ 0 ] }"`;
  for( let i = 1 ; i < keys.length ; i++ )
  result += `, "${ keys[ i ] }"`;
  return result.trim();
}

//

function __primitiveLike( src )
{
  if( _.primitive.is( src ) )
  return true;
  if( _.regexpIs( src ) )
  return true;
  if( _.routineIs( src ) )
  return true;
  return false;
}

//

function __strType( src )
{
  if( _.strType )
  return _.strType( src );
  return String( src );
}

//

function __mapSupplementWithoutUndefined( dstMap, srcMap )
{
  for( let k in srcMap )
  {
    if( Config.debug )
    _.assert
    (
      __primitiveLike( srcMap[ k ] ),
      `Defaults map should have only primitive elements, but option::${ k } is ${ __strType( srcMap[ k ] ) }`
    );
    if( dstMap[ k ] !== undefined )
    continue;
    dstMap[ k ] = srcMap[ k ];
  }
}

//

function __mapSupplementWithUndefined( dstMap, srcMap )
{
  for( let k in srcMap )
  {
    if( Config.debug )
    _.assert
    (
      __primitiveLike( srcMap[ k ] ),
      `Defaults map should have only primitive elements, but option::${ k } is ${ __strType( srcMap[ k ] ) }`
    );
    if( Object.hasOwnProperty.call( dstMap, k ) )
    continue;
    dstMap[ k ] = srcMap[ k ];
  }
}

// --
// dichotomy
// --

function is( src )
{
  let typeStr = Object.prototype.toString.call( src );
  return _.routine._is( src, typeStr );
}

//

function _is( src, typeStr )
{
  return typeStr === '[object Function]' || typeStr === '[object AsyncFunction]';
}

//

function like( src )
{
  let typeStr = Object.prototype.toString.call( src );
  return _.routine._like( src, typeStr );
}

//

function _like( src, typeStr )
{
  return typeStr === '[object Function]' || typeStr === '[object AsyncFunction]';
}

//

function routineIsTrivial_functor()
{

  const syncPrototype = Object.getPrototypeOf( Function );
  const asyncPrototype = Object.getPrototypeOf( _async );
  return routineIsTrivial;

  function routineIsTrivial( src )
  {
    if( !src )
    return false;
    let prototype = Object.getPrototypeOf( src );
    if( prototype === syncPrototype )
    return true;
    if( prototype === asyncPrototype )
    return true;
    return false;
  }

  async function _async()
  {
  }

}

let isTrivial = routineIsTrivial_functor();
isTrivial.functor = routineIsTrivial_functor;
// function routineIsTrivial( src )
// {
//   if( !src )
//   return false;
//   let proto = Object.getPrototypeOf( src );
//   if( proto === Object.getPrototypeOf( Function ) )
//   debugger;
//   if( proto === Object.getPrototypeOf( Function ) )
//   return true;
//   if( !proto )
//   return false;
//   if( !proto.constructor )
//   return false;
//   if( proto.constructor.name !== 'AsyncFunction' )
//   return false;
//   return true;
// }

//

function isSync( src )
{
  return Object.prototype.toString.call( src ) === '[object Function]'
}

//

function isAsync( src )
{
  return Object.prototype.toString.call( src ) === '[object AsyncFunction]'
}

//

function are( src )
{
  _.assert( arguments.length === 1, 'Expects single argument' );

  if( _.argumentsArray.like( src ) )
  {
    for( let s = 0 ; s < src.length ; s++ )
    if( !_.routine.is( src[ s ] ) )
    return false;
    return true;
  }

  return _.routine.is( src );
}

//

function withName( src )
{
  if( !routine.is( src ) )
  return false;
  if( !src.name )
  return false;
  return true;
}

// --
// joiner
// --

/**
 * Internal implementation.
 * @param {object} object - object to check.
 * @return {object} object - name in key/value format.
 * @function _routineJoin
 * @namespace Tools
 */

function _join( o )
{

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( _.bool.is( o.sealing ) );
  _.assert( _.bool.is( o.extending ) );
  _.assert( _.routine.is( o.routine ), 'Expects routine' );
  _.assert( _.longIs( o.args ) || o.args === undefined );

  let routine = o.routine;
  let args = o.args;
  let context = o.context;
  let result = act();

  if( o.extending )
  {
    _.props.extend( result, routine );

    let o2 =
    {
      value : routine,
      enumerable : false,
    };
    Object.defineProperty( result, 'originalRoutine', o2 ); /* qqq : cover */

    if( context !== undefined )
    {
      let o3 =
      {
        value : context,
        enumerable : false,
      };
      Object.defineProperty( result, 'boundContext', o3 ); /* qqq : cover */
    }

    if( args !== undefined )
    {
      let o3 =
      {
        value : args,
        enumerable : false,
      };
      Object.defineProperty( result, 'boundArguments', o3 ); /* qqq : cover */
    }

  }

  return result;

  /* */

  function act()
  {

    if( context !== undefined && args !== undefined )
    {
      if( o.sealing === true )
      {
        let name = routine.name || '__sealedContextAndArguments';
        _.assert( _.strIs( name ) );
        let __sealedContextAndArguments =
        {
          [ name ] : function()
          {
            return routine.apply( context, args );
          }
        }
        return __sealedContextAndArguments[ name ];
      }
      else
      {
        // let a = _.arrayAppendArray( [ context ], args );
        let a = [ context ]
        a.push( ... args );
        return Function.prototype.bind.apply( routine, a );
      }
    }
    else if( context !== undefined && args === undefined )
    {
      if( o.sealing === true )
      {
        let name = routine.name || '__sealedContext';
        let __sealedContext =
        {
          [ name ] : function()
          {
            return routine.call( context );
          }
        }
        return __sealedContext[ name ];
      }
      else
      {
        return Function.prototype.bind.call( routine, context );
      }
    }
    else if( context === undefined && args !== undefined )
    {
      if( o.sealing === true )
      {
        let name = routine.name || '__sealedArguments';
        _.assert( _.strIs( name ) );
        let __sealedContextAndArguments =
        {
          [ name ] : function()
          {
            return routine.apply( this, args );
          }
        }
        return __sealedContextAndArguments[ name ];
      }
      else
      {
        let name = routine.name || '__joinedArguments';
        let __joinedArguments =
        {
          [ name ] : function()
          {
            // let args2 = _.arrayAppendArrays( null, [ args, arguments ] );
            let args2 = [ ... args, ... arguments ];
            return routine.apply( this, args2 );
          }
        }
        return __joinedArguments[ name ];
      }
    }
    else if( context === undefined && args === undefined ) /* zzz */
    {
      return routine;
    }
    else _.assert( 0 );
  }

}

//

function constructorJoin( routine, args )
{

  _.assert( arguments.length === 1 || arguments.length === 2 );

  return _.routine._join
  ({
    routine,
    context : routine,
    args : args || [],
    sealing : false,
    extending : false,
  });

}

//

/**
 * The join() routine creates a new function with its 'this' ( context ) set to the provided `context`
 * value. Argumetns `args` of target function which are passed before arguments of binded function during
 * calling of target function. Unlike bind routine, position of `context` parameter is more intuitive.
 *
 * @example
 * let o = { z: 5 };
 * let y = 4;
 * function sum( x, y )
 * {
 *   return x + y + this.z;
 * }
 * let newSum = _.routine.join( o, sum, [ 3 ] );
 * newSum( y );
 * // returns 12
 *
 * @example
 * function f1()
 * {
 *   console.log( this )
 * };
 * let f2 = f1.bind( undefined ); // context of new function sealed to undefined (or global object);
 * f2.call( o ); // try to call new function with context set to { z: 5 }
 * let f3 = _.routine.join( undefined, f1 ); // new function.
 * f3.call( o )
 * // log { z: 5 }
 *
 * @param {Object} context The value that will be set as 'this' keyword in new function
 * @param {Function} routine Function which will be used as base for result function.
 * @param {Array<*>} args Argumetns of target function which are passed before arguments of binded function during
 calling of target function. Must be wraped into array.
 * @returns {Function} New created function with preceding this, and args.
 * @throws {Error} When second argument is not callable throws error with text 'first argument must be a routine'
 * @thorws {Error} If passed arguments more than 3 throws error with text 'Expects 3 or less arguments'
 * @function join
 * @namespace Tools
 */

function join( context, routine, args )
{

  _.assert( arguments.length <= 3, 'Expects 3 or less arguments' );

  return _.routine._join
  ({
    routine,
    context,
    args,
    sealing : false,
    extending : true,
  });

}

//

/**
 * The join() routine creates a new function with its 'this' ( context ) set to the provided `context`
 * value. Argumetns `args` of target function which are passed before arguments of binded function during
 * calling of target function. Unlike bind routine, position of `context` parameter is more intuitive.
 *
 * @example
 * let o = { z: 5 };
 * let y = 4;
 * function sum( x, y )
 * {
 *   return x + y + this.z;
 * }
 * let newSum = _.routine.join( o, sum, [ 3 ] );
 * newSum( y );
 * // returns 12
 *
 * @example
 * function f1()
 * {
 *   console.log( this )
 * };
 * let f2 = f1.bind( undefined ); // context of new function sealed to undefined (or global object);
 * f2.call( o ); // try to call new function with context set to { z: 5 }
 * let f3 = _.routine.join( undefined, f1 ); // new function.
 * f3.call( o )
 * // log { z: 5 }
 *
 * @param {Object} context The value that will be set as 'this' keyword in new function
 * @param {Function} routine Function which will be used as base for result function.
 * @param {Array<*>} args Argumetns of target function which are passed before arguments of binded function during
 calling of target function. Must be wraped into array.
 * @returns {Function} New created function with preceding this, and args.
 * @throws {Error} When second argument is not callable throws error with text 'first argument must be a routine'
 * @thorws {Error} If passed arguments more than 3 throws error with text 'Expects 3 or less arguments'
 * @function routineJoin
 * @namespace Tools
 */

function join( context, routine, args )
{

  _.assert( arguments.length <= 3, 'Expects 3 or less arguments' );

  return _.routine._join
  ({
    routine,
    context,
    args,
    sealing : false,
    extending : true,
  });

}

//

/**
 * Return new function with sealed context and arguments.
 *
 * @example
 * let o = { z : 5 };
 * function sum( x, y )
 * {
 *   return x + y + this.z;
 * }
 * let newSum = _.routine.seal( o, sum, [ 3, 4 ] );
 * newSum();
 * // returns : 12
 *
 * @param { Object } context - The value that will be set as 'this' keyword in new function
 * @param { Function } routine - Function which will be used as base for result function.
 * @param { Array } args - Arguments wrapped into array. Will be used as argument to `routine` function
 * @returns { Function } - Result function with sealed context and arguments.
 * @function seal
 * @namespace Tools
 */

function seal( context, routine, args )
{

  _.assert( arguments.length <= 3, 'Expects 3 or less arguments' );

  return _.routine._join
  ({
    routine,
    context,
    args,
    sealing : true,
    extending : true,
  });

}

// --
// options
// --

// //
//
// function mapOptionsApplyDefaults( options, defaults )
// {
//
//   _.assert( arguments.length === 2 );
//   _.map.assertHasOnly( options, defaults, `Does not expect options:` );
//   _.mapSupplementStructureless( options, defaults );
//   _.map.assertHasNoUndefine( options, `Options map should have no undefined fileds, but it does have` );
//
//   return options;
// }

/* qqq : for Dmytro : bad : discuss
should be { defaults : {} } in the first argument
*/

function optionsWithoutUndefined( routine, options )
{

  if( _.argumentsArray.like( options ) )
  {
    _.assert
    (
      options.length === 0 || options.length === 1,
      `Expects single options map, but got ${options.length} arguments`
    );
    if( options.length === 0 )
    options = Object.create( null )
    else
    options = options[ 0 ];
  }

  if( Config.debug )
  {
    _.assert( arguments.length === 2, 'Expects exactly 2 arguments' );
    _.assert( _.routineIs( routine ) || _.aux.is( routine ) || routine === null, 'Expects an object with options' );
    _.assert( _.objectIs( options ) || options === null, 'Expects an object with options' );
  }

  if( options === null || options === undefined )
  options = Object.create( null );

  let name = routine.name || '';
  let defaults = routine.defaults;
  _.assert( _.aux.is( defaults ), `Expects map of defaults, but got ${_.strType( defaults )}` );

  // if( options === undefined ) /* qqq : for Dmytro : bad : should be error */
  // options = Object.create( null );
  // if( defaults === null )
  // defaults = Object.create( null );

  // let name = _.routineIs( defaults ) ? defaults.name : '';
  // defaults = ( _.routineIs( defaults ) && defaults.defaults ) ? defaults.defaults : defaults;
  // _.assert( _.aux.is( defaults ), 'Expects defined defaults' );

  /* */

  if( Config.debug )
  {
    let extraKeys = __mapButKeys( options, defaults );
    _.assert( extraKeys.length === 0, () => `Routine "${ name }" does not expect options: ${ __keysQuote( extraKeys ) }` );
  }

  __mapSupplementWithoutUndefined( options, defaults );

  if( Config.debug )
  {
    let undefineKeys = __mapUndefinedKeys( options );
    _.assert
    (
      undefineKeys.length === 0,
      () => `Options map for routine "${ name }" should have no undefined fields, but it does have ${ __keysQuote( undefineKeys ) }`
    );
  }

  return options;
}

//

function assertOptionsWithoutUndefined( routine, options )
{

  if( _.argumentsArray.like( options ) )
  {
    _.assert
    (
      options.length === 0 || options.length === 1,
      `Expects single options map, but got ${options.length} arguments`
    );
    options = options[ 0 ];
  }

  if( Config.debug )
  {
    _.assert( arguments.length === 2, 'Expects exactly 2 arguments' );
    _.assert( _.routineIs( routine ) || _.aux.is( routine ) || routine === null, 'Expects an object with options' );
    _.assert( _.objectIs( options ) || options === null, 'Expects an object with options' );
  }

  let name = routine.name || '';
  let defaults = routine.defaults;
  _.assert( _.aux.is( defaults ), `Expects map of defaults, but got ${_.strType( defaults )}` );

  /* */

  if( Config.debug )
  {

    let extraKeys = __mapButKeys( options, defaults );
    _.assert( extraKeys.length === 0, () => `Routine "${ name }" does not expect options: ${ __keysQuote( extraKeys ) }` );

    let undefineKeys = __mapUndefinedKeys( options );
    _.assert
    (
      undefineKeys.length === 0,
      () => `Options map for routine "${ name }" should have no undefined fields, but it does have ${ __keysQuote( undefineKeys ) }`
    );

    for( let k in defaults )
    {
      _.assert
      (
        __primitiveLike( defaults[ k ] ),
        `Defaults map should have only primitive elements, but option::${ k } is ${ __strType( defaults[ k ] ) }`
      );
      _.assert
      (
        Reflect.has( options, k ),
        `Options map does not have option::${k}`
      )
    }

  }

  return options;
}

//

function optionsWithUndefined( routine, options )
{

  if( _.argumentsArray.like( options ) )
  {
    _.assert
    (
      options.length === 0 || options.length === 1,
      `Expects single options map, but got ${options.length} arguments`
    );
    if( options.length === 0 )
    options = Object.create( null )
    else
    options = options[ 0 ];
  }

  if( Config.debug )
  {
    _.assert( arguments.length === 2, 'Expects exactly 2 arguments' );
    _.assert( _.routineIs( routine ) || _.aux.is( routine ) || routine === null, 'Expects an object with options' );
    _.assert( _.objectIs( options ) || options === null, 'Expects an object with options' );
  }

  if( options === null )
  options = Object.create( null );
  let name = routine.name || '';
  let defaults = routine.defaults;
  _.assert( _.aux.is( defaults ), `Expects map of defaults, but got ${_.strType( defaults )}` );

  /* */

  if( Config.debug )
  {
    let extraKeys = __mapButKeys( options, defaults );
    _.assert( extraKeys.length === 0, () => `Routine "${ name }" does not expect options: ${ __keysQuote( extraKeys ) }` );
  }

  __mapSupplementWithUndefined( options, defaults );

  return options;
}

//

function assertOptionsWithUndefined( routine, options )
{

  if( _.argumentsArray.like( options ) )
  {
    _.assert
    (
      options.length === 0 || options.length === 1,
      `Expects single options map, but got ${options.length} arguments`
    );
    options = options[ 0 ];
  }

  if( Config.debug )
  {
    _.assert( arguments.length === 2, 'Expects exactly 2 arguments' );
    _.assert( _.routineIs( routine ) || _.aux.is( routine ) || routine === null, 'Expects an object with options' );
    _.assert( _.objectIs( options ) || options === null, 'Expects an object with options' );
  }

  let name = routine.name || '';
  let defaults = routine.defaults;
  _.assert( _.aux.is( defaults ), `Expects map of defaults, but got ${_.strType( defaults )}` );

  /* */

  if( Config.debug )
  {

    let extraKeys = __mapButKeys( options, defaults );
    _.assert( extraKeys.length === 0, () => `Routine "${ name }" does not expect options: ${ __keysQuote( extraKeys ) }` );

    for( let k in defaults )
    {
      _.assert
      (
        __primitiveLike( defaults[ k ] ),
        `Defaults map should have only primitive elements, but option::${ k } is ${ __strType( defaults[ k ] ) }`
      );
      _.assert
      (
        Reflect.has( options, k ),
        `Options map does not have option::${k}`
      )
    }

  }

  return options;
}

//

function _verifyDefaults( defaults )
{

  for( let k in defaults )
  {
    _.assert
    (
      __primitiveLike( defaults[ k ] ),
      `Defaults map should have only primitive elements, but option::${ k } is ${ __strType( defaults[ k ] ) }`
    );
  }

}

//

function options_deprecated( routine, args, defaults )
{

  if( !_.argumentsArray.like( args ) )
  args = [ args ];

  let options = args[ 0 ];
  if( options === undefined )
  options = Object.create( null );

  let name = routine ? routine.name : '';
  defaults = defaults || ( routine ? routine.defaults : null );

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects 2 or 3 arguments' );
  _.assert( _.routine.is( routine ) || routine === null, 'Expects routine' );
  _.assert( _.object.is( defaults ), 'Expects routine with defined defaults or defaults in third argument' );
  _.assert( _.object.is( options ), 'Expects object' );
  _.assert( args.length === 0 || args.length === 1, `Expects single options map, but got ${ args.length } arguments` );

  if( Config.debug )
  {
    let extraKeys = __mapButKeys( options, defaults );
    _.assert( extraKeys.length === 0, () => `Routine "${ name }" does not expect options: ${ __keysQuote( extraKeys ) }` );
  }

  __mapSupplementWithoutUndefined( options, defaults );

  if( Config.debug )
  {
    let undefineKeys = __mapUndefinedKeys( options );
    _.assert
    (
      undefineKeys.length === 0,
      () => `Options map for routine "${ name }" should have no undefined fields, but it does have option::${ __keysQuote( undefineKeys ) } = undefined`
    );
  }

  return options;
}

//

function assertOptions_deprecated( routine, args, defaults )
{

  if( !_.argumentsArray.like( args ) )
  args = [ args ];

  let options = args[ 0 ];

  defaults = defaults || ( routine ? routine.defaults : null );

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects 2 or 3 arguments' );
  _.assert( _.routine.is( routine ) || routine === null, 'Expects routine' );
  _.assert( _.aux.is( defaults ), 'Expects routine with defined defaults or defaults in third argument' );
  _.assert( _.aux.is( options ), 'Expects object' );
  _.assert( args.length === 0 || args.length === 1, `Expects single options map, but got ${ args.length } arguments` );

  if( Config.debug )
  {
    let extraOptionsKeys = __mapButKeys( options, defaults );
    _.assert( extraOptionsKeys.length === 0, () => `Object should have no fields : ${ __keysQuote( extraOptionsKeys ) }` );
    let extraDefaultsKeys = __mapButKeys( defaults, options );
    _.assert( extraDefaultsKeys.length === 0, () => `Object should have fields : ${ __keysQuote( extraDefaultsKeys ) }` );
    let undefineKeys = __mapUndefinedKeys( options );
    _.assert( undefineKeys.length === 0, () => `Object should have no undefines, but has : ${ __keysQuote( undefineKeys ) }` );
  }

  return options;

  // /* */
  //
  // function __mapButKeys( srcMap, butMap )
  // {
  //   let result = [];
  //
  //   for( let s in srcMap )
  //   if( !( s in butMap ) )
  //   result.push( s );
  //
  //   return result;
  // }
  //
  // /* */
  //
  // function __mapUndefinedKeys( srcMap )
  // {
  //   let result = [];
  //
  //   for( let s in srcMap )
  //   if( srcMap[ s ] === undefined )
  //   result.push( s );
  //
  //   return result;
  // }
  //
  // /* */
  //
  // function __keysQuote( keys )
  // {
  //   let result = `"${ keys[ 0 ] }"`;
  //   for( let i = 1 ; i < keys.length ; i++ )
  //   result += `, "${ keys[ i ] }"`;
  //   return result.trim();
  // }
}
//
// //
//
// function assertOptions_( defaults, options )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly 2 arguments' );
//   _.assert( _.routine.is( defaults ) || _.aux.is( defaults ) || defaults === null, 'Expects an object with options' );
//
//   if( _.argumentsArray.like( options ) )
//   {
//     _.assert
//     (
//       options.length === 0 || options.length === 1,
//       `Expects single options map, but got ${options.length} arguments`
//     );
//     options = options[ 0 ];
//   }
//
//   if( options === undefined )
//   options = Object.create( null );
//   if( defaults === null )
//   defaults = Object.create( null );
//
//   defaults = ( _.routine.is( defaults ) && defaults.defaults ) ? defaults.defaults : defaults;
//   _.assert( _.aux.is( defaults ), 'Expects defined defaults' );
//
//   /* */
//
//   if( Config.debug )
//   {
//     let extraOptionsKeys = __mapButKeys( options, defaults );
//     _.assert( extraOptionsKeys.length === 0, () => `Object should have no fields : ${ __keysQuote( extraOptionsKeys ) }` );
//     let extraDefaultsKeys = __mapButKeys( defaults, options );
//     _.assert( extraDefaultsKeys.length === 0, () => `Object should have fields : ${ __keysQuote( extraDefaultsKeys ) }` );
//     let undefineKeys = __mapUndefinedKeys( options );
//     _.assert( undefineKeys.length === 0, () => `Object should have no undefines, but has : ${ __keysQuote( undefineKeys ) }` );
//   }
//
//   return options;
//
//   /* */
//
//   // function __mapButKeys( srcMap, butMap )
//   // {
//   //   let result = [];
//   //
//   //   for( let s in srcMap )
//   //   if( !( s in butMap ) )
//   //   result.push( s );
//   //
//   //   return result;
//   // }
//   //
//   // /* */
//   //
//   // function __mapUndefinedKeys( srcMap )
//   // {
//   //   let result = [];
//   //
//   //   for( let s in srcMap )
//   //   if( srcMap[ s ] === undefined )
//   //   result.push( s );
//   //
//   //   return result;
//   // }
//   //
//   // /* */
//   //
//   // function __keysQuote( keys )
//   // {
//   //   let result = `"${ keys[ 0 ] }"`;
//   //   for( let i = 1 ; i < keys.length ; i++ )
//   //   result += `, "${ keys[ i ] }"`;
//   //   return result.trim();
//   // }
// }

// //
//
// /* aaa for Dmytro : forbid 3rd argument */ /* Dmytro : forbidden */
// /* aaa for Dmytro : inline implementation */ /* Dmytro : inlined */
// /* aaa for Dmytro : make possible pass defaults-map instead of routine */ /* Dmytro : implemented and covered */
// /* aaa for Dmytro : make sure _.routine.options_ and routine.options are similar */ /* Dmytro : implemented similar routine */
// /* xxx : make routine.options default routineOptions */
function optionsPreservingUndefines_deprecated( routine, args, defaults )
{

  if( !_.argumentsArray.like( args ) )
  args = [ args ];
  let options = args[ 0 ];
  if( options === undefined )
  options = Object.create( null );

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects 2 or 3 arguments' );
  _.assert( _.routine.is( routine ) || routine === null, 'Expects routine' );
  _.assert( _.aux.is( options ), 'Expects object' );
  _.assert( args.length === 0 || args.length === 1, `Expects single options map, but got ${options.length} arguments` );

  defaults = defaults || routine.defaults;

  _.assert( _.aux.is( defaults ), 'Expects routine with defined defaults' );
  _.map.assertHasOnly( options, defaults );
  _.mapComplementPreservingUndefines( options, defaults );

  return options;
}

// //
//
// function optionsPreservingUndefines_( defaults, options )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly 2 arguments' );
//   _.assert( _.routineIs( defaults ) || _.aux.is( defaults ) || defaults === null, 'Expects an object with options' );
//
//   if( _.argumentsArray.like( options ) )
//   {
//     _.assert
//     (
//       options.length === 0 || options.length === 1,
//       `Expects single options map, but got ${options.length} arguments`
//     );
//     options = options[ 0 ];
//   }
//
//   if( options === undefined )
//   options = Object.create( null );
//   if( defaults === null )
//   defaults = Object.create( null );
//
//   let name = '';
//   if( _.routine.is( defaults ) )
//   {
//     name = defaults.name;
//     defaults = defaults.defaults;
//   }
//
//   // let name = _.routine.is( defaults ) ? defaults.name : '';
//   // defaults = ( _.routine.is( defaults ) && defaults.defaults ) ? defaults.defaults : defaults;
//   _.assert( _.aux.is( defaults ), 'Expects defined defaults' );
//
//   /* */
//
//   if( Config.debug )
//   {
//     let extraKeys = __mapButKeys( options, defaults );
//     _.assert( extraKeys.length === 0, () => `Routine "${ name }" does not expect options: ${ __keysQuote( extraKeys ) }` );
//   }
//
//   __mapSupplementWithUndefined( options, defaults );
//
//   return options;
//
//   // /* */
//   //
//   // function __mapButKeys( srcMap, butMap )
//   // {
//   //   let result = [];
//   //
//   //   for( let key in srcMap )
//   //   if( !( key in butMap ) )
//   //   result.push( key );
//   //
//   //   return result;
//   // }
//   //
//   // /* */
//   //
//   // function __keysQuote( keys )
//   // {
//   //   let result = `"${ keys[ 0 ] }"`;
//   //   for( let i = 1 ; i < keys.length ; i++ )
//   //   result += `, "${ keys[ i ] }"`;
//   //   return result.trim();
//   // }
//   //
//   // /* */
//   //
//   // function mapComplementPreservingUndefinesMin( dstMap, srcMap )
//   // {
//   //   for( let key in srcMap )
//   //   {
//   //     if( Object.hasOwnProperty.call( dstMap, key ) )
//   //     continue;
//   //
//   //     if( _.arrayIs( srcMap[ key ] ) )
//   //     dstMap[ key ] = srcMap[ key ].slice();
//   //     else if( _.mapIs( srcMap[ key ] ) )
//   //     dstMap[ key ] = getCopy( srcMap[ key ] );
//   //     else
//   //     dstMap[ key ] = srcMap[ key ];
//   //   }
//   // }
//   //
//   // /* */
//   //
//   // function getCopy( src )
//   // {
//   //   if( _.routineIs( src.clone ) )
//   //   _.assert( 0, 'unknown' );
//   //
//   //   let result = Object.create( null );
//   //   for( let key in src )
//   //   {
//   //     _.assert( _.strIs( key ) );
//   //     result[ key ] = src[ key ];
//   //   }
//   //   Object.setPrototypeOf( result, Object.getPrototypeOf( src ) );
//   //   return result;
//   // }
// }

//

function assertOptionsPreservingUndefines_deprecated( routine, args, defaults )
{

  if( !_.argumentsArray.like( args ) )
  args = [ args ];
  let options = args[ 0 ];
  defaults = defaults || routine.defaults;

  _.assert( arguments.length === 2 || arguments.length === 3, 'Expects 2 or 3 arguments' );
  _.assert( _.routine.is( routine ), 'Expects routine' );
  _.assert( _.object.is( defaults ), 'Expects routine with defined defaults or defaults in third argument' );
  _.assert( _.object.is( options ), 'Expects object' );
  _.assert( args.length === 0 || args.length === 1, 'Expects single options map, but got', args.length, 'arguments' );

  _.map.assertHasOnly( options, defaults );
  _.map.assertHasAll( options, defaults );

  /* qqq : for Dmytro : rewrite without using higher level. discuss */

  return options;
}

// //
//
// function assertOptionsPreservingUndefines_( defaults, options )
// {
//
//   _.assert( arguments.length === 2, 'Expects exactly 2 arguments' );
//   _.assert( _.routineIs( defaults ) || _.aux.is( defaults ) || defaults === null, 'Expects an object with options' );
//
//   if( _.argumentsArray.like( options ) )
//   {
//     _.assert
//     (
//       options.length === 0 || options.length === 1,
//       `Expects single options map, but got ${options.length} arguments`
//     );
//     options = options[ 0 ];
//   }
//
//   if( options === undefined )
//   options = Object.create( null );
//   if( defaults === null )
//   defaults = Object.create( null );
//
//   defaults = ( _.routineIs( defaults ) && defaults.defaults ) ? defaults.defaults : defaults;
//   _.assert( _.aux.is( defaults ), 'Expects defined defaults' );
//
//   /* */
//
//   if( Config.debug )
//   {
//     let extraOptionsKeys = __mapButKeys( options, defaults );
//     _.assert( extraOptionsKeys.length === 0, () => `Object should have no fields : ${ __keysQuote( extraOptionsKeys ) }` );
//
//     let extraDefaultsKeys = __mapButKeys( defaults, options );
//     _.assert( extraDefaultsKeys.length === 0, () => `Object should have fields : ${ __keysQuote( extraDefaultsKeys ) }` );
//   }
//
//   return options;
//
//   // /* */
//   //
//   // function __mapButKeys( srcMap, butMap )
//   // {
//   //   let result = [];
//   //
//   //   for( let key in srcMap )
//   //   if( !( key in butMap ) )
//   //   result.push( key );
//   //
//   //   return result;
//   // }
//   //
//   // /* */
//   //
//   // function __keysQuote( keys )
//   // {
//   //   let result = `"${ keys[ 0 ] }"`;
//   //   for( let i = 1 ; i < keys.length ; i++ )
//   //   result += `, "${ keys[ i ] }"`;
//   //   return result.trim();
//   // }
// }

// //
//
// /* xxx : deprecated */
// function optionsFromThis( routine, _this, constructor )
// {
//
//   _.assert( arguments.length === 3, 'Expects 3 arguments' );
//
//   let options = _this || Object.create( null );
//   if( Object.isPrototypeOf.call( constructor, _this ) || constructor === _this )
//   options = Object.create( null );
//
//   return _.routine.options( routine, options );
// }

//

function _routinesCompose_head( routine, args )
{
  let o = args[ 0 ];

  if( !_.mapIs( o ) )
  o = { elements : args[ 0 ] }
  if( args[ 1 ] !== undefined )
  o.chainer = args[ 1 ];

  // o.elements = _.arrayAppendArrays( [], [ o.elements ] );
  o.elements = merge( o.elements );
  o.elements = o.elements.filter( ( e ) => e !== null );

  _.routine.options( routine, o );
  _.assert( _.routine.s.are( o.elements ) );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( args.length === 1 || args.length === 2 );
  _.assert( args.length === 1 || !_.object.is( args[ 0 ] ) );
  _.assert( _.arrayIs( o.elements ) || _.routine.is( o.elements ) );
  _.assert( _.routine.is( args[ 1 ] ) || args[ 1 ] === undefined || args[ 1 ] === null );
  _.assert( o.chainer === null || _.routine.is( o.chainer ) );
  _.assert( o.supervisor === null || _.routine.is( o.supervisor ) );

  return o;

  function merge( arrays )
  {
    let result = [];
    for( let i = 0 ; i < arrays.length ; i++ )
    {
      let array = arrays[ i ];
      if( _.array.is( array ) || _.argumentsArray.is( array ) )
      result.push( ... array );
      else
      result.push( array );
    }
    return result;
  }
}

//

function _routinesCompose_body( o )
{

  if( o.chainer === null )
  o.chainer = _.compose.chainer.original;

  o.elements = _.arrayFlatten( o.elements );

  let elements = [];
  for( let s = 0 ; s < o.elements.length ; s++ )
  {
    let src = o.elements[ s ];
    _.assert( _.routine.is( src ) );
    if( src.composed )
    {
      if( src.composed.chainer === o.chainer && src.composed.supervisor === o.supervisor )
      {
        // _.arrayAppendArray( elements, src.composed.elements );
        elements.push( ... src.composed.elements );
      }
      else
      {
        // _.arrayAppendElement( elements, src );
        elements.push( ... src );
      }
    }
    else
    {
      elements.push( src );
      // _.arrayAppendElement( elements, src );
    }
  }

  o.elements = elements;

  let supervisor = o.supervisor;
  let chainer = o.chainer;
  let act;

  _.assert( _.routine.is( chainer ) );
  _.assert( supervisor === null || _.routine.is( supervisor ) );

  /* */

  if( elements.length === 0 )
  act = function empty()
  {
    return [];
  }
  // else if( elements.length === 1 ) /* zzz : optimize the case */
  // {
  //   act = elements[ 0 ];
  // }
  else act = function composition()
  {
    let result = [];
    // let args = _.unrollAppend( _.unroll.from( null ), arguments );
    let args = _.unroll.from( arguments );
    for( let k = 0 ; k < elements.length ; k++ )
    {
      _.assert( _.unrollIs( args ), () => 'Expects unroll, but got', _.entity.strType( args ) );
      let routine = elements[ k ];
      let r = routine.apply( this, args );
      _.assert( r !== false /* && r !== undefined */, 'Temporally forbidden type of result', r );
      _.assert( !_.argumentsArray.is( r ) );
      if( r !== undefined )
      _.unrollAppend( result, r );
      // args = chainer( r, k, args, o );
      args = chainer( args, r, o, k );
      _.assert( args !== undefined && args !== false );
      // if( args === undefined )
      if( args === _.dont )
      break;
      args = _.unroll.from( args );
    }
    return result;
  }

  o.act = act;
  act.composed = o;

  if( supervisor )
  {
    _.routine.extend( compositionSupervise, act );
    return compositionSupervise;
  }

  return act;

  function compositionSupervise()
  {
    let result = supervisor( this, arguments, act, o );
    return result;
  }
}

_routinesCompose_body.defaults =
{
  elements : null,
  chainer : null,
  supervisor : null,
}

//

function compose()
{
  let o = _.routine.s.compose.head( compose, arguments );
  let result = _.routine.s.compose.body( o );
  return result;
}

compose.head = _routinesCompose_head;
compose.body = _routinesCompose_body;
compose.defaults = Object.assign( Object.create( null ), compose.body.defaults );

// --
// amend
// --

/* qqq : for Dmytro : cover and optimize */
function _amend( o )
{
  let dst = o.dst;
  let srcs = o.srcs;
  let srcIsVector = _.vectorIs( srcs );
  let extended = false;

  _.routine.assertOptions( _amend, o );
  _.assert( arguments.length === 1 );
  _.assert( _.routine.is( dst ) || dst === null );
  _.assert( srcs === null || srcs === undefined || _.aux.is( srcs ) || _.routine.is( srcs ) || _.vector.is( srcs ) );
  _.assert( o.amending === 'extending', 'not implemented' );
  _.assert
  (
    o.strategy === 'cloning' || o.strategy === 'replacing' || o.strategy === 'inheriting',
    () => `Unknown strategy ${o.strategy}`
  );

  /* generate dst routine */

  if( dst === null ) /* qqq : for Dmytro : good coverage required */
  dst = _dstMake( srcs );

  // /* shallow clone properties of dst routine */
  //
  // if( o.strategy === 'cloning' )
  // _fieldsClone( dst );
  // else if( o.strategy === 'inheriting' )
  // _fieldsInherit( dst );

  /* extend dst routine */

  let _dstAmend;
  if( o.strategy === 'cloning' )
  _dstAmend = _dstAmendCloning;
  else if( o.strategy === 'replacing' )
  _dstAmend = _dstAmendReplacing;
  else if( o.strategy === 'inheriting' )
  _dstAmend = _dstAmendInheriting;
  else _.assert( 0, 'not implemented' );

  if( srcIsVector )
  for( let src of srcs )
  _dstAmend( dst, src );
  else
  _dstAmend( dst, srcs );

  /* qqq : for Dmytro : it should be optimal, no redundant cloning of body should happen
  check and cover it by good test, please
  */
  if( extended )
  // if( dst.body && dst.body.defaults )
  if( dst.body )
  dst.body = bodyFrom( dst.body );

  if( Config.debug )
  {
    /* qqq : for Dmytro : cover, please */
    if( _.strEnds( dst.name, '_body' ) )
    {
      _.assert( dst.body === undefined, 'Body of routine should not have its own body' );
      _.assert( dst.head === undefined, 'Body of routine should not have its own head' );
      _.assert( dst.tail === undefined, 'Body of routine should not have its own tail' );
    }
    // xxx : uncomment?
    // if( dst.defaults )
    // _.routine._verifyDefaults( dst.defaults );
  }

  return dst;

  /* */

  function _dstMake( srcs )
  {
    let dstMap = Object.create( null );

    /* qqq : option amendment influence on it */
    if( srcIsVector )
    for( let src of srcs )
    {
      if( src === null )
      continue;
      _.props.extend( dstMap, src );
    }
    else
    {
      if( srcs !== null )
      _.props.extend( dstMap, srcs );
    }

    if( dstMap.body )
    {
      // dst = _.routine.uniteCloning( dstMap.head, dstMap.body );
      dst = _.routine.unite
      ({
        head : dstMap.head || null,
        body : dstMap.body || null,
        tail : dstMap.tail || null,
        name : dstMap.name || null,
        strategy : o.strategy,
      });
    }
    else
    {
      if( srcIsVector )
      dst = dstFrom( srcs[ 0 ] );
      else
      dst = dstFrom( srcs );
    }

    _.assert( _.routineIs( dst ) );
    // _.props.extend( dst, dstMap );

    return dst;
  }

  /* */

  // function _fieldsClone( dst )
  // {
  //
  //   for( let s in dst )
  //   {
  //     let property = dst[ s ];
  //     if( _.objectIs( property ) )
  //     {
  //       property = _.props.extend( null, property );
  //       dst[ s ] = property;
  //     }
  //   }
  //
  // }
  //
  // /* */
  //
  // function _fieldsInherit( dst )
  // {
  //
  //   for( let s in dst )
  //   {
  //     let property = dst[ s ];
  //     if( _.objectIs( property ) )
  //     {
  //       property = Object.create( property );
  //       dst[ s ] = property;
  //     }
  //   }
  //
  // }

  /* */

  function _dstAmendCloning( dst, src )
  {
    _.assert( !!dst );
    _.assert( _.aux.is( src ) || _.routine.is( src ) );
    for( let s in src )
    {
      let property = src[ s ];
      if( dst[ s ] === property )
      continue;
      let d = Object.getOwnPropertyDescriptor( dst, s );
      if( d && !d.writable )
      continue;
      extended = true;
      if( _.object.is( property ) )
      {
        _.assert( !_.props.own( dst, s ) || _.objectIs( dst[ s ] ) );

        if( dst[ s ] )
        _.props.extend( dst[ s ], property );
        else
        dst[ s ] = property = _.props.extend( null, property );

        // property = _.props.extend( null, property );
        // if( dst[ s ] )
        // _.props.supplement( property, dst[ s ] );
      }
      else
      {
        dst[ s ] = property;
      }
    }
  }

  /* */

  function _dstAmendInheriting( dst, src )
  {
    _.assert( !!dst );
    _.assert( _.aux.is( src ) || _.routine.is( src ) );
    /* qqq : for Dmytro : on extending should inherit from the last one, on supplementing should inherit from the first one
    implement, and cover in separate test
    */
    for( let s in src )
    {
      let property = src[ s ];
      if( dst[ s ] === property )
      continue;
      let d = Object.getOwnPropertyDescriptor( dst, s );
      if( d && !d.writable )
      continue;
      extended = true;
      if( _.object.is( property ) )
      {
        property = Object.create( property );
        if( dst[ s ] )
        _.props.supplement( property, dst[ s ] );
      }
      dst[ s ] = property;
    }
  }

  /* */

  function _dstAmendReplacing( dst, src )
  {
    _.assert( !!dst );
    _.assert( _.aux.is( src ) || _.routine.is( src ) );
    for( let s in src )
    {
      let property = src[ s ];
      if( dst[ s ] === property )
      continue;
      let d = Object.getOwnPropertyDescriptor( dst, s );
      if( d && !d.writable )
      continue;
      extended = true;
      dst[ s ] = property;
    }
  }

  /* */

  function bodyFrom()
  {
    const body = dst.body;
    let body2 = body;
    _.assert( body.head === undefined, 'Body should not have own head' );
    _.assert( body.tail === undefined, 'Body should not have own tail' );
    _.assert( body.body === undefined, 'Body should not have own body' );
    {
      let srcs = srcIsVector ? _.map_( null, o.srcs, ( src ) => propertiesBut( src ) ) : [ propertiesBut( o.srcs ) ];
      srcs.unshift( body );
      body2 = _.routine._amend
      ({
        dst : o.strategy === 'replacing' ? body2 : null,
        srcs,
        strategy : o.strategy,
        amending : o.amending,
      });
      _.assert( body2.head === undefined, 'Body should not have own head' );
      _.assert( body2.tail === undefined, 'Body should not have own tail' );
      _.assert( body2.body === undefined, 'Body should not have own body' );
    }
    return body2;
  }

  /* */

  function propertiesBut( src )
  {
    return src ? _.mapBut_( null, src, [ 'head', 'body', 'tail' ] ) : src;
  }

  /* */

  /* xxx : make routine? */
  function routineClone( routine )
  {
    _.assert( _.routine.is( routine ) );
    let name = routine.name;
    // const routine2 = routine.bind();
    // _.assert( routine2 !== routine );
    const routine2 =
    ({
      [ name ] : function()
      {
        return routine.apply( this, arguments );
      }
    })[ name ];

    let o2 =
    {
      value : routine,
      enumerable : false,
    };
    Object.defineProperty( routine2, 'originalRoutine', o2 ); /* qqq : for Dmytro : cover */

    return routine2;
  }

  /* */

  function dstFrom( routine )
  {
    return routineClone( routine );
  }

  /* */

}

_amend.defaults =
{
  dst : null,
  srcs : null,
  strategy : 'cloning', /* qqq : for Dmytro : cover */
  amending : 'extending', /* qqq : for Dmytro : implement and cover */
}

//

/**
 * The routine _.routine.extendCloning() is used to copy the values of all properties
 * from source routine to a target routine.
 *
 * It takes first routine (dst), and shallow clone each destination property of type map.
 * Then it checks properties of source routine (src) and extends dst by source properties.
 * The dst properties can be owerwriten by values of source routine
 * if descriptor (writable) of dst property is set.
 *
 * If the first routine (dst) is null then
 * routine _.routine.extendCloning() makes a routine from routines head and body
 * @see {@link wTools.routine.unite} - Automatic routine generating
 * from preparation routine and main routine (body).
 *
 * @param{ routine } dst - The target routine or null.
 * @param{ * } src - The source routine or object to copy.
 *
 * @example
 * var src =
 * {
 *   head : _.routine.s.compose.head,
 *   body : _.routine.s.compose.body,
 *   someOption : 1,
 * }
 * var got = _.routine.extendCloning( null, src );
 * // returns [ routine routinesCompose ], got.option === 1
 *
 * @example
 * _.routine.extendCloning( null, _.routine.s.compose );
 * // returns [ routine routinesCompose ]
 *
 * @example
 * _.routine.extendCloning( _.routine.s.compose, { someOption : 1 } );
 * // returns [ routine routinesCompose ], routinesCompose.someOption === 1
 *
 * @example
 * _.routine.s.composes.someOption = 22;
 * _.routine.extendCloning( _.routine.s.compose, { someOption : 1 } );
 * // returns [ routine routinesCompose ], routinesCompose.someOption === 1
 *
 * @returns { routine } It will return the target routine with extended properties.
 * @function extendCloning
 * @throws { Error } Throw an error if arguments.length < 1 or arguments.length > 2.
 * @throws { Error } Throw an error if dst is not routine or not null.
 * @throws { Error } Throw an error if dst is null and src has not head and body properties.
 * @throws { Error } Throw an error if src is primitive value.
 * @namespace Tools
 */

function extendCloning( dst, ... srcs )
{

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  return _.routine._amend
  ({
    dst,
    srcs : [ ... srcs ],
    strategy : 'cloning',
    amending : 'extending',
  });

}

// qqq : for Dmytro : cover please
function extendInheriting( dst, ... srcs )
{

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  return _.routine._amend
  ({
    dst,
    srcs : [ ... srcs ],
    strategy : 'inheriting',
    amending : 'extending',
  });

}

//
/*qqq : for Dmytro : cover please */
function extendReplacing( dst, ... srcs )
{

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  return _.routine._amend
  ({
    dst,
    srcs : [ ... srcs ],
    strategy : 'replacing',
    amending : 'extending',
  });

}

//

function defaults( dst, src, defaults )
{

  if( arguments.length === 2 )
  {
    defaults = arguments[ 1 ];
    _.assert( _.aux.is( defaults ) );
    return _.routine.extend( dst, { defaults } );
  }
  else
  {
    _.assert( arguments.length === 3 );
    _.assert( _.aux.is( defaults ) );
    return _.routine.extend( dst, src, { defaults } );
  }

  // _.assert( dst === null || src === null );
  // _.assert( _.aux.is( defaults ) );
  // return _.routine.extend( dst, src, { defaults } );
}

// --
// unite
// --

function unite_head( routine, args )
{
  let o = args[ 0 ];

  if( args[ 1 ] !== undefined )
  {
    if( args.length === 3 )
    o = { head : args[ 0 ], body : args[ 1 ], tail : args[ 2 ] };
    else
    o = { head : args[ 0 ], body : ( args.length > 1 ? args[ 1 ] : null ) };
  }

  _.routine.optionsWithoutUndefined( routine, o );
  _.assert( args.length === 1 || args.length === 2 || args.length === 3 );
  _.assert( arguments.length === 2 );
  _.assert
  (
    o.head === null || _.numberIs( o.head ) || _.routine.is( o.head ) || _.routine.s.are( o.head )
    , 'Expects either routine, routines or number of arguments {-o.head-}'
  );
  _.assert( _.routine.is( o.body ), 'Expects routine {-o.body-}' );
  _.assert( o.tail === null || _.routine.is( o.tail ), () => `Expects routine {-o.tail-}, but got ${_.entity.strType( o.tail )}` );
  _.assert( o.body.defaults !== undefined, 'Body should have defaults' );

  return o;
}

//

function unite_body( o )
{

  if( _.longIs( o.head ) )
  {
    /* xxx : deprecate compose */
    /* qqq : for Dmytro : implement without compose */
    let _head = _.routine.s.compose( o.head, function( /* args, result, op, k */ )
    {
      let args = arguments[ 0 ];
      let result = arguments[ 1 ];
      let op = arguments[ 2 ];
      let k = arguments[ 3 ];
      _.assert( arguments.length === 4 );
      _.assert( !_.unrollIs( result ) );
      _.assert( _.object.is( result ) );
      return _.unrollAppend([ unitedRoutine, [ result ] ]);
    });
    _.assert( _.routine.is( _head ) );
    o.head = function head()
    {
      let result = _head.apply( this, arguments );
      return result[ result.length-1 ];
    }
  }
  else if( _.number.is( o.head ) )
  {
    o.head = headWithNargs_functor( o.head, o.body );
  }

  if( o.head === null )
  {
    /* qqq : for Dmytro : cover please */
    if( o.body.defaults )
    o.head = headWithDefaults;
    else
    o.head = headWithoutDefaults;
  }

  if( !o.name )
  {
    _.assert( _.strDefined( o.body.name ), 'Body routine should have name' );
    o.name = o.body.name;
    if( o.name.indexOf( '_body' ) === o.name.length-5 && o.name.length > 5 )
    o.name = o.name.substring( 0, o.name.length-5 );
  }

  /* generate body */

  /* qqq : for Dmytro : cover in separate test routine */
  let body;
  if( o.strategy === 'replacing' )
  body = o.body;
  else
  body = _.routine._amend
  ({
    dst : null,
    srcs : o.body,
    strategy : o.strategy,
    amending : 'extending',
  });

  /* make routine */

  let unitedRoutine = _unite_functor( o.name, o.head, body, o.tail );

  _.assert( _.strDefined( unitedRoutine.name ), 'Looks like your interpreter does not support dynamic naming of functions. Please use ES2015 or later interpreter.' );

  /* qqq : for Dmytro : cover option::strategy */

  _.routine._amend
  ({
    dst : unitedRoutine,
    srcs : body,
    strategy : 'replacing',
    amending : 'extending',
  });

  unitedRoutine.head = o.head;
  unitedRoutine.body = body;
  if( o.tail )
  unitedRoutine.tail = o.tail;

  _.assert
  (
    unitedRoutine.defaults === body.defaults,
    'Something wrong, united routined should have same instance of defaults its body has'
  );

  return unitedRoutine;

  function headWithNargs_functor( nargs, body )
  {
    _.assert( !!o.body.defaults );
    return function headWithDefaults( routine, args )
    {
      _.assert( args.length <= nargs+1 );
      _.assert( arguments.length === 2 );
      let o = _.routine.options( routine, args[ nargs ] || Object.create( null ) );
      return _.unroll.from([ ... Array.prototype.slice.call( args, 0, nargs ), o ]);
    }
  }

  /* */

  function headWithoutDefaults( routine, args )
  {
    let o = args[ 0 ];
    _.assert( arguments.length === 2 );
    _.assert( args.length === 0 || args.length === 1 );
    _.assert( args.length === 0 || o === undefined || o === null || _.auxIs( o ) );
    return o || null;
  }

  /* */

  function headWithDefaults( routine, args )
  {
    let o = args[ 0 ];
    _.assert( arguments.length === 2 );
    _.assert( args.length === 0 || args.length === 1 );
    _.assert( args.length === 0 || o === undefined || o === null || _.auxIs( o ) );
    return _.routine.options( routine, o || Object.create( null ) );
  }

  /* */

  function _unite_functor()
  {
    const name = arguments[ 0 ];
    const head = arguments[ 1 ];
    const body = arguments[ 2 ];
    const tail = arguments[ 3 ];
    let r;

    _.assert( head === null || _.routineIs( head ) );
    _.assert( body === null || _.routineIs( body ) );
    _.assert( tail === null || _.routineIs( tail ) );

    if( tail === null )
    r =
    {
      [ name ] : function()
      {
        let result;
        let o = head.call( this, unitedRoutine, arguments );

        _.assert( !_.argumentsArray.is( o ), 'does not expect arguments array' );

        if( _.unrollIs( o ) )
        result = body.apply( this, o );
        else
        result = body.call( this, o );

        return result;
      }
    };
    else if( head === null )
    r =
    {
      [ name ] : function()
      {
        let result;
        let o = arguments[ 0 ];

        _.assert( arguments.length === 1, 'Expects single argument {-o-}.' );

        if( _.unrollIs( o ) )
        result = body.apply( this, o );
        else if( _.mapIs( o ) )
        result = body.call( this, o );
        else
        _.assert( 0, 'Unexpected type of {-o-}, expects options map or unroll.' );

        result = tail.call( this, result, o );

        return result;
      }
    };
    else
    r =
    {
      [ name ] : function()
      {
        let result;
        let o = head.call( this, unitedRoutine, arguments );

        _.assert( !_.argumentsArray.is( o ), 'does not expect arguments array' );

        if( _.unrollIs( o ) )
        result = body.apply( this, o );
        else
        result = body.call( this, o );

        debugger;
        result = tail.call( this, result, o );

        return result;
      }
    };

    return r[ name ]
  }
}

unite_body.defaults =
{
  head : null,
  body : null,
  tail : null,
  name : null,
  strategy : null,
}

//

/* qqq : for Dmytro : write the article. it should explain why, when, what for! */
function uniteCloning()
{
  let o = uniteCloning.head.call( this, uniteCloning, arguments );
  let result = uniteCloning.body.call( this, o );
  return result;
}

uniteCloning.head = unite_head;
uniteCloning.body = unite_body;
uniteCloning.defaults = { ... unite_body.defaults, strategy : 'cloning' };

//

function uniteInheriting()
{
  let o = uniteInheriting.head.call( this, uniteInheriting, arguments );
  let result = uniteInheriting.body.call( this, o );
  return result;
}

uniteInheriting.head = unite_head;
uniteInheriting.body = unite_body;
uniteInheriting.defaults = { ... unite_body.defaults, strategy : 'inheriting' };

//

function uniteReplacing()
{
  let o = uniteReplacing.head.call( this, uniteReplacing, arguments );
  let result = uniteReplacing.body.call( this, o );
  return result;
}

uniteReplacing.head = unite_head;
uniteReplacing.body = unite_body;
uniteReplacing.defaults = { ... unite_body.defaults, strategy : 'replacing' };

//

function exportStringShallowDiagnostic( src )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument' );
  _.assert( _.routine.is( src ) );

  if( src.name )
  return `{- routine ${src.name} -}`;
  else
  return `{- routine.anonymous -}`;
}

// --
// implementation
// --

let ToolsExtension =
{

  routineIs : is,
  _routineIs : _is,
  routineLike : like,
  _routineLike : _like,
  routineIsTrivial : isTrivial,
  routineIsSync : isSync,
  routineIsAsync : isAsync,
  routinesAre : are,
  routineWithName : withName,

  _routineJoin : _join,
  constructorJoin,
  routineJoin : join,
  routineSeal : seal,

  routinesCompose : compose, /* xxx : deprecate */
  routineExtend : extendCloning,
  routineDefaults : defaults,

}

Object.assign( _, ToolsExtension );

//

let RoutineExtension =
{

  // dichotomy

  is,
  _is,
  like,
  _like,
  isTrivial,
  isSync,
  isAsync,
  withName,

  // joiner

  _join,
  constructorJoin,
  join,
  seal,

  // option

  optionsWithoutUndefined,
  assertOptionsWithoutUndefined,
  optionsWithUndefined,
  assertOptionsWithUndefined,
  options : optionsWithUndefined,
  assertOptions : assertOptionsWithUndefined,
  options_ : optionsWithUndefined,
  assertOptions_ : assertOptionsWithUndefined,
  _verifyDefaults,

  options_deprecated,
  assertOptions_deprecated,
  optionsPreservingUndefines_deprecated,
  assertOptionsPreservingUndefines_deprecated,

  // amend

  _amend,
  extend : extendCloning,
  extendCloning,
  extendInheriting,
  extendReplacing,
  defaults,

  // unite

  unite : uniteReplacing,
  uniteCloning,
  uniteCloning_replaceByUnite : uniteCloning,
  uniteInheriting,
  uniteReplacing,
  /* qqq : cover routines uniteReplacing, uniteInheriting, uniteCloning */

  // exporter

  exportString : exportStringShallowDiagnostic,
  exportStringShallow : exportStringShallowDiagnostic,
  exportStringShallowDiagnostic,
  exportStringShallowCode : exportStringShallowDiagnostic,
  exportStringDiagnostic : exportStringShallowDiagnostic,
  exportStringCode : exportStringShallowDiagnostic,

}

Object.assign( _.routine, RoutineExtension );

//

let RoutinesExtension =
{

  are,
  compose,

}

Object.assign( _.routine.s, RoutinesExtension );

})();