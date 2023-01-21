// SPDX-License-Identifier: MIT OR Apache-2.0
//
// Copyright (c) 2018-2022 Andre Richter <andre.o.richter@gmail.com>

//! Device driver.

#[cfg(any(feature = "bsp_rpi3"))]
mod bcm;
mod common;

#[cfg(any(feature = "bsp_rpi3"))]
pub use bcm::*;
