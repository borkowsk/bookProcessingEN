/// @file 
/* All sources included in one file. */
/// @date 2024-10-15 (0.22j)
#include "processing_consts.hpp"
#include "processing_templates.hpp"
#include "processing_library.hpp"
#include "processing_window.hpp"
#ifdef _NDEBUG
#include "processing_inlines.hpp" //...is optional.
#endif // _NDEBUG
#include "processing_console.hpp"   //...is optional. Should be deleted when not needed.
using namespace Processing;
#include "local.h"
#include <iostream>
//==============================================================================
const char* Processing::_PROGRAMNAME="logistic_gr_if_colors_animated";
#include "logistic_gr_if_colors_animated.pde.hpp"
