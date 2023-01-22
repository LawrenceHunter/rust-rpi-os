// SPDX-License-Identifier: MIT OR Apache-2.0
//
// Copyright (c) 2018-2022 Andre Richter <andre.o.richter@gmail.com>

//! Conditional reexporting of Board Support Packages.

mod device_driver;

#[cfg(feature = "bsp_rpi3")]
mod raspberrypi;

#[cfg(feature = "bsp_rpi3")]
pub use raspberrypi::*;
