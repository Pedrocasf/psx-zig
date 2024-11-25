/*
 * Linker script to generate an ELF file
 * that has to be converted to PS-X EXE.
 */

MEMORY {
    ram	(rwx) : ORIGIN = 0x80010000, LENGTH = 2M - 64K
    sram (rw) : ORIGIN = 0x1f800000, LENGTH = 1K
}

OUTPUT_FORMAT("elf32-tradlittlemips")
OUTPUT_ARCH("mips")
ENTRY(start)

SECTIONS
{
	. = ORIGIN(ram);
	.text ALIGN(4) :
	{
	    KEEP(*(._start))
		*(.text*)
	} >ram

	.rodata ALIGN(4) :
	{
		*(.rodata)
	} >ram

	.data ALIGN(4) :
	{
		 *(.data)
	} >ram

	.bss  ALIGN(4) :
	{
		*(.bss)
	} >ram

	__text_start = ADDR(.text);
	__text_end = ADDR(.text) + SIZEOF(.text);

	__rodata_start = ADDR(.rodata);
	__rodata_end = ADDR(.rodata) + SIZEOF(.rodata);

	__data_start = ADDR(.data);
	__data_end = ADDR(.data) + SIZEOF(.data);

	__bss_start = ADDR(.bss);
	__bss_end = ADDR(.bss) + SIZEOF(.bss);

}
