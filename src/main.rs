// SPDX-License-Identifier: MIT OR Apache-2.0
//
// Copyright (c) 2018-2022 Andre Richter <andre.o.richter@gmail.com>

//! The `kernel` binary.
//!
//! 1. The kernel's entry point is the function `cpu::boot::arch_boot::_start()`.
//!     - It is implemented in `src/_arch/__arch_name__/cpu/boot.s`.
//! 2. Once finished with architectural setup, the arch code calls `kernel_init()`.

#![feature(asm_const)]
#![feature(format_args_nl)]
#![feature(panic_info_message)]
#![no_main]
#![no_std]

mod bsp;
mod console;
mod cpu;
mod panic_wait;
mod print;

/// Early init code.
///
/// # Safety
///
/// - Only a single core must be active and running this function.
unsafe fn kernel_init() -> ! {
    println!("Hello from Rust!");
    panic!("Stopping here.")
}
