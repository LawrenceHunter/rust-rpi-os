// SPDX-License-Identifier: MIT OR Apache-2.0
//
// Copyright (c) 2021-2022 Andre Richter <andre.o.richter@gmail.com>

//--------------------------------------------------------------------------------------------------
// Definitions
//--------------------------------------------------------------------------------------------------
.macro ADR_REL register, symbol
	adrp	\register, \symbol
	add		\register, \register, #:lo12:\symbol
.endm


//--------------------------------------------------------------------------------------------------
// Public Code
//--------------------------------------------------------------------------------------------------
.section .text._start

//------------------------------------------------------------------------------
// fn _start()
//------------------------------------------------------------------------------
_start:
	// Only proceed if the core executes EL2
	mrs		x0, CurrentEL
	cmp 	x0, {CONST_CURRENTEL_EL2}
	b.ne 	.L_parking_loop

	mrs		x1, MPIDR_EL1
	and 	x1, x1, {CONST_CORE_ID_MASK}
	ldr 	x2, BOOT_CORE_ID
	cmp 	x1, x2
	b.ne 	.L_parking_loop

	ADR_REL x0, __bss_start
	ADR_REL x1, __bss_end_exclusive

.L_bss_init_loop:
	cmp		x0, x1
	b.eq 	.L_prepare_rust
	stp		xzr, xzr, [x0], #16
	b 		.L_bss_init_loop

.L_prepare_rust:
	ADR_REL x0, __boot_core_stack_end_exclusive
	mov		sp, x0

	// Read CPU's timer counter frequency and store it
	ADR_REL x1, ARCH_TIMER_COUNTER_FREQUENCY
	mrs		x2, CNTFRQ_EL0
	cmp		x2, xzr
	b.eq	.L_parking_loop
	str 	w2, [x1]
	b		_start_rust

.L_parking_loop:
	wfe
	b	.L_parking_loop

.size	_start, . - _start
.type	_start, function
.global	_start
