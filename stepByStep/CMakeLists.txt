cmake_minimum_required(VERSION 3.12)
project(stepByStep)

set(CMAKE_C_STANDARD 99)

include_directories(.)

#include_directories(c2/f/cli)
#include_directories(c2/f/include)
#include_directories(c2/f/vm)
#include_directories(c2/f/parser)


#include_directories(c2/cli)
#include_directories(c2/include)
#include_directories(c2/vm)
#include_directories(c2/parser)

#include_directories(c3/cli)
#include_directories(c3/include)
#include_directories(c3/vm)
#include_directories(c3/parser)
#include_directories(c3/object)

#include_directories(c4/cli)
#include_directories(c4/compiler)
#include_directories(c4/include)
#include_directories(c4/vm)
#include_directories(c4/parser)
#include_directories(c4/object)

#include_directories(c6/cli)
#include_directories(c6/compiler)
#include_directories(c6/include)
#include_directories(c6/vm)
#include_directories(c6/parser)
#include_directories(c6/object)

#include_directories(c8/cli)
#include_directories(c8/compiler)
#include_directories(c8/include)
#include_directories(c8/vm)
#include_directories(c8/parser)
#include_directories(c8/object)

add_executable(stepByStep main.c

        #        c2/f/cli/cli.c
        #        c2/f/cli/cli.h
        #        c2/f/include/common.h

        #       c2/f/include/utils.c
        #        c2/f/include/utils.h
        #        c2/f/vm/vm.c
        #        c2/f/vm/vm.h
        #        c2/f/vm/core.c
        #        c2/f/vm/core.h

        #       c2/f/include/unicodeUtf8.c
        #       c2/f/include/unicodeUtf8.h
        #       c2/f/parser/parser.c
        #       c2/f/parser/parser.h


        #        c2/cli/cli.c
        #        c2/cli/cli.h
        #        c2/include/common.h
        #
        #        c2/include/utils.c
        #        c2/include/utils.h
        #        c2/vm/vm.c
        #        c2/vm/vm.h
        #        c2/vm/core.c
        #        c2/vm/core.h
        #
        #        c2/include/unicodeUtf8.c
        #        c2/include/unicodeUtf8.h
        #        c2/parser/parser.c
        #        c2/parser/parser.h

        #        c3/cli/cli.c
        #        c3/cli/cli.h
        #        c3/include/common.h
        #
        #        c3/include/utils.c
        #        c3/include/utils.h
        #        c3/vm/vm.c
        #        c3/vm/vm.h
        #        c3/vm/core.c
        #        c3/vm/core.h
        #
        #        c3/include/unicodeUtf8.c
        #        c3/include/unicodeUtf8.h
        #        c3/parser/parser.c
        #        c3/parser/parser.h
        #
        #        c3/object/header_obj.c
        #        c3/object/header_obj.h
        #        c3/object/class.c
        #        c3/object/class.h
        #        c3/object/obj_fn.h
        #        c3/object/obj_string.h
        #        c3/object/obj_string.c
        #        c3/object/meta_obj.c
        #        c3/object/meta_obj.h
        #        c3/object/obj_fn.c
        #        c3/object/obj_list.c
        #        c3/object/obj_list.h
        #        c3/object/obj_range.c
        #        c3/object/obj_range.h
        #        c3/object/obj_map.c
        #        c3/object/obj_map.h
        #        c3/object/obj_thread.c
        #        c3/object/obj_thread.h

        #        c4/cli/cli.c
        #        c4/cli/cli.h
        #        c4/include/common.h
        #
        #        c4/include/utils.c
        #        c4/include/utils.h
        #        c4/vm/vm.c
        #        c4/vm/vm.h
        #        c4/vm/core.c
        #        c4/vm/core.h
        #
        #        c4/include/unicodeUtf8.c
        #        c4/include/unicodeUtf8.h
        #        c4/parser/parser.c
        #        c4/parser/parser.h
        #
        #        c4/object/header_obj.c
        #        c4/object/header_obj.h
        #        c4/object/class.c
        #        c4/object/class.h
        #        c4/object/obj_fn.h
        #        c4/object/obj_string.h
        #        c4/object/obj_string.c
        #        c4/object/meta_obj.c
        #        c4/object/meta_obj.h
        #        c4/object/obj_fn.c
        #        c4/object/obj_list.c
        #        c4/object/obj_list.h
        #        c4/object/obj_range.c
        #        c4/object/obj_range.h
        #        c4/object/obj_map.c
        #        c4/object/obj_map.h
        #        c4/object/obj_thread.c
        #        c4/object/obj_thread.h
        #        c4/compiler/compiler.c
        #        c4/compiler/compiler.h

#        c6/cli/cli.c
#        c6/cli/cli.h
#        c6/include/common.h
#
#        c6/include/utils.c
#        c6/include/utils.h
#        c6/vm/vm.c
#        c6/vm/vm.h
#        c6/vm/core.c
#        c6/vm/core.h
#
#        c6/include/unicodeUtf8.c
#        c6/include/unicodeUtf8.h
#        c6/parser/parser.c
#        c6/parser/parser.h
#
#        c6/object/header_obj.c
#        c6/object/header_obj.h
#        c6/object/class.c
#        c6/object/class.h
#        c6/object/obj_fn.h
#        c6/object/obj_string.h
#        c6/object/obj_string.c
#        c6/object/meta_obj.c
#        c6/object/meta_obj.h
#        c6/object/obj_fn.c
#        c6/object/obj_list.c
#        c6/object/obj_list.h
#        c6/object/obj_range.c
#        c6/object/obj_range.h
#        c6/object/obj_map.c
#        c6/object/obj_map.h
#        c6/object/obj_thread.c
#        c6/object/obj_thread.h
#        c6/compiler/compiler.c
#        c6/compiler/compiler.h

#        c8/cli/cli.c
#        c8/cli/cli.h
#        c8/include/common.h
#
#        c8/include/utils.c
#        c8/include/utils.h
#        c8/vm/vm.c
#        c8/vm/vm.h
#        c8/vm/core.c
#        c8/vm/core.h
#
#        c8/include/unicodeUtf8.c
#        c8/include/unicodeUtf8.h
#        c8/parser/parser.c
#        c8/parser/parser.h
#
#        c8/object/header_obj.c
#        c8/object/header_obj.h
#        c8/object/class.c
#        c8/object/class.h
#        c8/object/obj_fn.h
#        c8/object/obj_string.h
#        c8/object/obj_string.c
#        c8/object/meta_obj.c
#        c8/object/meta_obj.h
#        c8/object/obj_fn.c
#        c8/object/obj_list.c
#        c8/object/obj_list.h
#        c8/object/obj_range.c
#        c8/object/obj_range.h
#        c8/object/obj_map.c
#        c8/object/obj_map.h
#        c8/object/obj_thread.c
#        c8/object/obj_thread.h
#        c8/compiler/compiler.c
#        c8/compiler/compiler.h

        )
