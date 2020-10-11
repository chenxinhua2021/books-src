/*
 * _mingw.h
 *
 * Mingw specific macros included by ALL include files. 
 *
 * This file is part of the Mingw32 package.
 *
 * Contributors:
 *  Created by Mumit Khan  <khan@xraylith.wisc.edu>
 *
 *  THIS SOFTWARE IS NOT COPYRIGHTED
 *
 *  This source code is offered for use in the public domain. You may
 *  use, modify or distribute it freely.
 *
 *  This code is distributed in the hope that it will be useful but
 *  WITHOUT ANY WARRANTY. ALL WARRANTIES, EXPRESS OR IMPLIED ARE HEREBY
 *  DISCLAMED. This includes but is not limited to warranties of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

#ifndef __MINGW_H
#define __MINGW_H

/* These are defined by the user (or the compiler)
   to specify how identifiers are imported from a DLL.

   __DECLSPEC_SUPPORTED    Defined if dllimport attribute is supported.
   __MINGW_IMPORT          The attribute definition to specify imported
                           variables/functions. 
  
   All headers should include this first, and then use __DECLSPEC_SUPPORTED
   to choose between the old ``__imp__name'' style or __MINGW_IMPORT
   style declarations.  */

#ifndef __GNUC__
# define __MINGW_IMPORT  __declspec(dllimport)
# define __DECLSPEC_SUPPORTED
#else /* __GNUC__ */
# ifdef __declspec
   /* note the extern at the end. This is needed to work around GCC's
      limitations in handling dllimport attribute.  */
#  define __MINGW_IMPORT __attribute__((dllimport)) extern
#  define __DECLSPEC_SUPPORTED
# else
#  undef __DECLSPEC_SUPPORTED
#  undef __MINGW_IMPORT
# endif 
#endif /* __GNUC__ */

#endif /* __MINGW_H */

