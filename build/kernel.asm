
build/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <_entry>:
    .section .text.entry
    .globl _entry
_entry:
    la sp, boot_stack_top
    80200000:	00012117          	auipc	sp,0x12
    80200004:	00010113          	mv	sp,sp
    call main
    80200008:	2e2000ef          	jal	ra,802002ea <main>

000000008020000c <printint>:
#include "console.h"
#include "defs.h"
static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign)
{
    8020000c:	7179                	addi	sp,sp,-48
    8020000e:	f406                	sd	ra,40(sp)
    80200010:	f022                	sd	s0,32(sp)
    80200012:	ec26                	sd	s1,24(sp)
    80200014:	e84a                	sd	s2,16(sp)
    80200016:	1800                	addi	s0,sp,48
	char buf[16];
	int i;
	uint x;

	if (sign && (sign = xx < 0))
    80200018:	c219                	beqz	a2,8020001e <printint+0x12>
    8020001a:	08054663          	bltz	a0,802000a6 <printint+0x9a>
		x = -xx;
	else
		x = xx;
    8020001e:	2501                	sext.w	a0,a0
    80200020:	4881                	li	a7,0
    80200022:	fd040693          	addi	a3,s0,-48

	i = 0;
    80200026:	4701                	li	a4,0
	do {
		buf[i++] = digits[x % base];
    80200028:	2581                	sext.w	a1,a1
    8020002a:	00001617          	auipc	a2,0x1
    8020002e:	01e60613          	addi	a2,a2,30 # 80201048 <digits>
    80200032:	883a                	mv	a6,a4
    80200034:	2705                	addiw	a4,a4,1
    80200036:	02b577bb          	remuw	a5,a0,a1
    8020003a:	1782                	slli	a5,a5,0x20
    8020003c:	9381                	srli	a5,a5,0x20
    8020003e:	97b2                	add	a5,a5,a2
    80200040:	0007c783          	lbu	a5,0(a5)
    80200044:	00f68023          	sb	a5,0(a3)
	} while ((x /= base) != 0);
    80200048:	0005079b          	sext.w	a5,a0
    8020004c:	02b5553b          	divuw	a0,a0,a1
    80200050:	0685                	addi	a3,a3,1
    80200052:	feb7f0e3          	bgeu	a5,a1,80200032 <printint+0x26>

	if (sign)
    80200056:	00088b63          	beqz	a7,8020006c <printint+0x60>
		buf[i++] = '-';
    8020005a:	fe040793          	addi	a5,s0,-32
    8020005e:	973e                	add	a4,a4,a5
    80200060:	02d00793          	li	a5,45
    80200064:	fef70823          	sb	a5,-16(a4)
    80200068:	0028071b          	addiw	a4,a6,2

	while (--i >= 0)
    8020006c:	02e05763          	blez	a4,8020009a <printint+0x8e>
    80200070:	fd040793          	addi	a5,s0,-48
    80200074:	00e784b3          	add	s1,a5,a4
    80200078:	fff78913          	addi	s2,a5,-1
    8020007c:	993a                	add	s2,s2,a4
    8020007e:	377d                	addiw	a4,a4,-1
    80200080:	1702                	slli	a4,a4,0x20
    80200082:	9301                	srli	a4,a4,0x20
    80200084:	40e90933          	sub	s2,s2,a4
		consputc(buf[i]);
    80200088:	fff4c503          	lbu	a0,-1(s1)
    8020008c:	00000097          	auipc	ra,0x0
    80200090:	1f8080e7          	jalr	504(ra) # 80200284 <consputc>
	while (--i >= 0)
    80200094:	14fd                	addi	s1,s1,-1
    80200096:	ff2499e3          	bne	s1,s2,80200088 <printint+0x7c>
}
    8020009a:	70a2                	ld	ra,40(sp)
    8020009c:	7402                	ld	s0,32(sp)
    8020009e:	64e2                	ld	s1,24(sp)
    802000a0:	6942                	ld	s2,16(sp)
    802000a2:	6145                	addi	sp,sp,48
    802000a4:	8082                	ret
		x = -xx;
    802000a6:	40a0053b          	negw	a0,a0
	if (sign && (sign = xx < 0))
    802000aa:	4885                	li	a7,1
		x = -xx;
    802000ac:	bf9d                	j	80200022 <printint+0x16>

00000000802000ae <printf>:
		consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(char *fmt, ...)
{
    802000ae:	7131                	addi	sp,sp,-192
    802000b0:	fc86                	sd	ra,120(sp)
    802000b2:	f8a2                	sd	s0,112(sp)
    802000b4:	f4a6                	sd	s1,104(sp)
    802000b6:	f0ca                	sd	s2,96(sp)
    802000b8:	ecce                	sd	s3,88(sp)
    802000ba:	e8d2                	sd	s4,80(sp)
    802000bc:	e4d6                	sd	s5,72(sp)
    802000be:	e0da                	sd	s6,64(sp)
    802000c0:	fc5e                	sd	s7,56(sp)
    802000c2:	f862                	sd	s8,48(sp)
    802000c4:	f466                	sd	s9,40(sp)
    802000c6:	f06a                	sd	s10,32(sp)
    802000c8:	ec6e                	sd	s11,24(sp)
    802000ca:	0100                	addi	s0,sp,128
    802000cc:	8a2a                	mv	s4,a0
    802000ce:	e40c                	sd	a1,8(s0)
    802000d0:	e810                	sd	a2,16(s0)
    802000d2:	ec14                	sd	a3,24(s0)
    802000d4:	f018                	sd	a4,32(s0)
    802000d6:	f41c                	sd	a5,40(s0)
    802000d8:	03043823          	sd	a6,48(s0)
    802000dc:	03143c23          	sd	a7,56(s0)
	va_list ap;
	int i, c;
	char *s;

	if (fmt == 0)
    802000e0:	c915                	beqz	a0,80200114 <printf+0x66>
		panic("null fmt");

	va_start(ap, fmt);
    802000e2:	00840793          	addi	a5,s0,8
    802000e6:	f8f43423          	sd	a5,-120(s0)
	for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    802000ea:	000a4503          	lbu	a0,0(s4)
    802000ee:	16050c63          	beqz	a0,80200266 <printf+0x1b8>
    802000f2:	4981                	li	s3,0
		if (c != '%') {
    802000f4:	02500a93          	li	s5,37
			continue;
		}
		c = fmt[++i] & 0xff;
		if (c == 0)
			break;
		switch (c) {
    802000f8:	07000b93          	li	s7,112
	consputc('x');
    802000fc:	4d41                	li	s10,16
		consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    802000fe:	00001b17          	auipc	s6,0x1
    80200102:	f4ab0b13          	addi	s6,s6,-182 # 80201048 <digits>
		switch (c) {
    80200106:	07300c93          	li	s9,115
			printptr(va_arg(ap, uint64));
			break;
		case 's':
			if ((s = va_arg(ap, char *)) == 0)
				s = "(null)";
			for (; *s; s++)
    8020010a:	02800d93          	li	s11,40
		switch (c) {
    8020010e:	06400c13          	li	s8,100
    80200112:	a889                	j	80200164 <printf+0xb6>
		panic("null fmt");
    80200114:	00000097          	auipc	ra,0x0
    80200118:	194080e7          	jalr	404(ra) # 802002a8 <threadid>
    8020011c:	86aa                	mv	a3,a0
    8020011e:	02e00793          	li	a5,46
    80200122:	00001717          	auipc	a4,0x1
    80200126:	ee670713          	addi	a4,a4,-282 # 80201008 <e_text+0x8>
    8020012a:	00001617          	auipc	a2,0x1
    8020012e:	eee60613          	addi	a2,a2,-274 # 80201018 <e_text+0x18>
    80200132:	45fd                	li	a1,31
    80200134:	00001517          	auipc	a0,0x1
    80200138:	eec50513          	addi	a0,a0,-276 # 80201020 <e_text+0x20>
    8020013c:	00000097          	auipc	ra,0x0
    80200140:	f72080e7          	jalr	-142(ra) # 802000ae <printf>
    80200144:	00000097          	auipc	ra,0x0
    80200148:	28e080e7          	jalr	654(ra) # 802003d2 <shutdown>
    8020014c:	bf59                	j	802000e2 <printf+0x34>
			consputc(c);
    8020014e:	00000097          	auipc	ra,0x0
    80200152:	136080e7          	jalr	310(ra) # 80200284 <consputc>
	for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    80200156:	2985                	addiw	s3,s3,1
    80200158:	013a07b3          	add	a5,s4,s3
    8020015c:	0007c503          	lbu	a0,0(a5)
    80200160:	10050363          	beqz	a0,80200266 <printf+0x1b8>
		if (c != '%') {
    80200164:	ff5515e3          	bne	a0,s5,8020014e <printf+0xa0>
		c = fmt[++i] & 0xff;
    80200168:	2985                	addiw	s3,s3,1
    8020016a:	013a07b3          	add	a5,s4,s3
    8020016e:	0007c783          	lbu	a5,0(a5)
    80200172:	0007849b          	sext.w	s1,a5
		if (c == 0)
    80200176:	cbe5                	beqz	a5,80200266 <printf+0x1b8>
		switch (c) {
    80200178:	05778a63          	beq	a5,s7,802001cc <printf+0x11e>
    8020017c:	02fbf663          	bgeu	s7,a5,802001a8 <printf+0xfa>
    80200180:	09978863          	beq	a5,s9,80200210 <printf+0x162>
    80200184:	07800713          	li	a4,120
    80200188:	0ce79463          	bne	a5,a4,80200250 <printf+0x1a2>
			printint(va_arg(ap, int), 16, 1);
    8020018c:	f8843783          	ld	a5,-120(s0)
    80200190:	00878713          	addi	a4,a5,8
    80200194:	f8e43423          	sd	a4,-120(s0)
    80200198:	4605                	li	a2,1
    8020019a:	85ea                	mv	a1,s10
    8020019c:	4388                	lw	a0,0(a5)
    8020019e:	00000097          	auipc	ra,0x0
    802001a2:	e6e080e7          	jalr	-402(ra) # 8020000c <printint>
			break;
    802001a6:	bf45                	j	80200156 <printf+0xa8>
		switch (c) {
    802001a8:	09578e63          	beq	a5,s5,80200244 <printf+0x196>
    802001ac:	0b879263          	bne	a5,s8,80200250 <printf+0x1a2>
			printint(va_arg(ap, int), 10, 1);
    802001b0:	f8843783          	ld	a5,-120(s0)
    802001b4:	00878713          	addi	a4,a5,8
    802001b8:	f8e43423          	sd	a4,-120(s0)
    802001bc:	4605                	li	a2,1
    802001be:	45a9                	li	a1,10
    802001c0:	4388                	lw	a0,0(a5)
    802001c2:	00000097          	auipc	ra,0x0
    802001c6:	e4a080e7          	jalr	-438(ra) # 8020000c <printint>
			break;
    802001ca:	b771                	j	80200156 <printf+0xa8>
			printptr(va_arg(ap, uint64));
    802001cc:	f8843783          	ld	a5,-120(s0)
    802001d0:	00878713          	addi	a4,a5,8
    802001d4:	f8e43423          	sd	a4,-120(s0)
    802001d8:	0007b903          	ld	s2,0(a5)
	consputc('0');
    802001dc:	03000513          	li	a0,48
    802001e0:	00000097          	auipc	ra,0x0
    802001e4:	0a4080e7          	jalr	164(ra) # 80200284 <consputc>
	consputc('x');
    802001e8:	07800513          	li	a0,120
    802001ec:	00000097          	auipc	ra,0x0
    802001f0:	098080e7          	jalr	152(ra) # 80200284 <consputc>
    802001f4:	84ea                	mv	s1,s10
		consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    802001f6:	03c95793          	srli	a5,s2,0x3c
    802001fa:	97da                	add	a5,a5,s6
    802001fc:	0007c503          	lbu	a0,0(a5)
    80200200:	00000097          	auipc	ra,0x0
    80200204:	084080e7          	jalr	132(ra) # 80200284 <consputc>
	for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80200208:	0912                	slli	s2,s2,0x4
    8020020a:	34fd                	addiw	s1,s1,-1
    8020020c:	f4ed                	bnez	s1,802001f6 <printf+0x148>
    8020020e:	b7a1                	j	80200156 <printf+0xa8>
			if ((s = va_arg(ap, char *)) == 0)
    80200210:	f8843783          	ld	a5,-120(s0)
    80200214:	00878713          	addi	a4,a5,8
    80200218:	f8e43423          	sd	a4,-120(s0)
    8020021c:	6384                	ld	s1,0(a5)
    8020021e:	cc89                	beqz	s1,80200238 <printf+0x18a>
			for (; *s; s++)
    80200220:	0004c503          	lbu	a0,0(s1)
    80200224:	d90d                	beqz	a0,80200156 <printf+0xa8>
				consputc(*s);
    80200226:	00000097          	auipc	ra,0x0
    8020022a:	05e080e7          	jalr	94(ra) # 80200284 <consputc>
			for (; *s; s++)
    8020022e:	0485                	addi	s1,s1,1
    80200230:	0004c503          	lbu	a0,0(s1)
    80200234:	f96d                	bnez	a0,80200226 <printf+0x178>
    80200236:	b705                	j	80200156 <printf+0xa8>
				s = "(null)";
    80200238:	00001497          	auipc	s1,0x1
    8020023c:	dc848493          	addi	s1,s1,-568 # 80201000 <e_text>
			for (; *s; s++)
    80200240:	856e                	mv	a0,s11
    80200242:	b7d5                	j	80200226 <printf+0x178>
			break;
		case '%':
			consputc('%');
    80200244:	8556                	mv	a0,s5
    80200246:	00000097          	auipc	ra,0x0
    8020024a:	03e080e7          	jalr	62(ra) # 80200284 <consputc>
			break;
    8020024e:	b721                	j	80200156 <printf+0xa8>
		default:
			// Print unknown % sequence to draw attention.
			consputc('%');
    80200250:	8556                	mv	a0,s5
    80200252:	00000097          	auipc	ra,0x0
    80200256:	032080e7          	jalr	50(ra) # 80200284 <consputc>
			consputc(c);
    8020025a:	8526                	mv	a0,s1
    8020025c:	00000097          	auipc	ra,0x0
    80200260:	028080e7          	jalr	40(ra) # 80200284 <consputc>
			break;
    80200264:	bdcd                	j	80200156 <printf+0xa8>
		}
	}
    80200266:	70e6                	ld	ra,120(sp)
    80200268:	7446                	ld	s0,112(sp)
    8020026a:	74a6                	ld	s1,104(sp)
    8020026c:	7906                	ld	s2,96(sp)
    8020026e:	69e6                	ld	s3,88(sp)
    80200270:	6a46                	ld	s4,80(sp)
    80200272:	6aa6                	ld	s5,72(sp)
    80200274:	6b06                	ld	s6,64(sp)
    80200276:	7be2                	ld	s7,56(sp)
    80200278:	7c42                	ld	s8,48(sp)
    8020027a:	7ca2                	ld	s9,40(sp)
    8020027c:	7d02                	ld	s10,32(sp)
    8020027e:	6de2                	ld	s11,24(sp)
    80200280:	6129                	addi	sp,sp,192
    80200282:	8082                	ret

0000000080200284 <consputc>:
#include "console.h"
#include "sbi.h"

void consputc(int c)
{
    80200284:	1141                	addi	sp,sp,-16
    80200286:	e406                	sd	ra,8(sp)
    80200288:	e022                	sd	s0,0(sp)
    8020028a:	0800                	addi	s0,sp,16
	console_putchar(c);
    8020028c:	00000097          	auipc	ra,0x0
    80200290:	116080e7          	jalr	278(ra) # 802003a2 <console_putchar>
}
    80200294:	60a2                	ld	ra,8(sp)
    80200296:	6402                	ld	s0,0(sp)
    80200298:	0141                	addi	sp,sp,16
    8020029a:	8082                	ret

000000008020029c <console_init>:

void console_init()
{
    8020029c:	1141                	addi	sp,sp,-16
    8020029e:	e422                	sd	s0,8(sp)
    802002a0:	0800                	addi	s0,sp,16
	// DO NOTHING
    802002a2:	6422                	ld	s0,8(sp)
    802002a4:	0141                	addi	sp,sp,16
    802002a6:	8082                	ret

00000000802002a8 <threadid>:
extern char e_data[];
extern char s_bss[];
extern char e_bss[];

int threadid()
{
    802002a8:	1141                	addi	sp,sp,-16
    802002aa:	e422                	sd	s0,8(sp)
    802002ac:	0800                	addi	s0,sp,16
	return 0;
}
    802002ae:	4501                	li	a0,0
    802002b0:	6422                	ld	s0,8(sp)
    802002b2:	0141                	addi	sp,sp,16
    802002b4:	8082                	ret

00000000802002b6 <clean_bss>:

void clean_bss()
{
    802002b6:	1141                	addi	sp,sp,-16
    802002b8:	e422                	sd	s0,8(sp)
    802002ba:	0800                	addi	s0,sp,16
	char *p;
	for (p = s_bss; p < e_bss; ++p)
    802002bc:	00012717          	auipc	a4,0x12
    802002c0:	d4470713          	addi	a4,a4,-700 # 80212000 <boot_stack_top>
    802002c4:	00012797          	auipc	a5,0x12
    802002c8:	d3c78793          	addi	a5,a5,-708 # 80212000 <boot_stack_top>
    802002cc:	00f77c63          	bgeu	a4,a5,802002e4 <clean_bss+0x2e>
    802002d0:	87ba                	mv	a5,a4
    802002d2:	00012717          	auipc	a4,0x12
    802002d6:	d2e70713          	addi	a4,a4,-722 # 80212000 <boot_stack_top>
		*p = 0;
    802002da:	00078023          	sb	zero,0(a5)
	for (p = s_bss; p < e_bss; ++p)
    802002de:	0785                	addi	a5,a5,1
    802002e0:	fee79de3          	bne	a5,a4,802002da <clean_bss+0x24>
}
    802002e4:	6422                	ld	s0,8(sp)
    802002e6:	0141                	addi	sp,sp,16
    802002e8:	8082                	ret

00000000802002ea <main>:

void main()
{
    802002ea:	1141                	addi	sp,sp,-16
    802002ec:	e406                	sd	ra,8(sp)
    802002ee:	e022                	sd	s0,0(sp)
    802002f0:	0800                	addi	s0,sp,16
	clean_bss();
    802002f2:	00000097          	auipc	ra,0x0
    802002f6:	fc4080e7          	jalr	-60(ra) # 802002b6 <clean_bss>
	console_init();
    802002fa:	00000097          	auipc	ra,0x0
    802002fe:	fa2080e7          	jalr	-94(ra) # 8020029c <console_init>
	printf("\n");
    80200302:	00001517          	auipc	a0,0x1
    80200306:	de650513          	addi	a0,a0,-538 # 802010e8 <digits+0xa0>
    8020030a:	00000097          	auipc	ra,0x0
    8020030e:	da4080e7          	jalr	-604(ra) # 802000ae <printf>
	printf("hello wrold!\n");
    80200312:	00001517          	auipc	a0,0x1
    80200316:	d4e50513          	addi	a0,a0,-690 # 80201060 <digits+0x18>
    8020031a:	00000097          	auipc	ra,0x0
    8020031e:	d94080e7          	jalr	-620(ra) # 802000ae <printf>
	errorf("stext: %p", s_text);
    80200322:	00000717          	auipc	a4,0x0
    80200326:	cde70713          	addi	a4,a4,-802 # 80200000 <_entry>
    8020032a:	4681                	li	a3,0
    8020032c:	00001617          	auipc	a2,0x1
    80200330:	d4460613          	addi	a2,a2,-700 # 80201070 <digits+0x28>
    80200334:	45fd                	li	a1,31
    80200336:	00001517          	auipc	a0,0x1
    8020033a:	d4250513          	addi	a0,a0,-702 # 80201078 <digits+0x30>
    8020033e:	00000097          	auipc	ra,0x0
    80200342:	d70080e7          	jalr	-656(ra) # 802000ae <printf>
	infof("sroda: %p", s_rodata);
	debugf("eroda: %p", e_rodata);
	debugf("sdata: %p", s_data);
	infof("edata: %p", e_data);
	warnf("sbss : %p", s_bss);
	errorf("ebss : %p", e_bss);
    80200346:	00012717          	auipc	a4,0x12
    8020034a:	cba70713          	addi	a4,a4,-838 # 80212000 <boot_stack_top>
    8020034e:	4681                	li	a3,0
    80200350:	00001617          	auipc	a2,0x1
    80200354:	d2060613          	addi	a2,a2,-736 # 80201070 <digits+0x28>
    80200358:	45fd                	li	a1,31
    8020035a:	00001517          	auipc	a0,0x1
    8020035e:	d3e50513          	addi	a0,a0,-706 # 80201098 <digits+0x50>
    80200362:	00000097          	auipc	ra,0x0
    80200366:	d4c080e7          	jalr	-692(ra) # 802000ae <printf>
	panic("ALL DONE");
    8020036a:	02700793          	li	a5,39
    8020036e:	00001717          	auipc	a4,0x1
    80200372:	d4a70713          	addi	a4,a4,-694 # 802010b8 <digits+0x70>
    80200376:	4681                	li	a3,0
    80200378:	00001617          	auipc	a2,0x1
    8020037c:	ca060613          	addi	a2,a2,-864 # 80201018 <e_text+0x18>
    80200380:	45fd                	li	a1,31
    80200382:	00001517          	auipc	a0,0x1
    80200386:	d4650513          	addi	a0,a0,-698 # 802010c8 <digits+0x80>
    8020038a:	00000097          	auipc	ra,0x0
    8020038e:	d24080e7          	jalr	-732(ra) # 802000ae <printf>
    80200392:	00000097          	auipc	ra,0x0
    80200396:	040080e7          	jalr	64(ra) # 802003d2 <shutdown>
}
    8020039a:	60a2                	ld	ra,8(sp)
    8020039c:	6402                	ld	s0,0(sp)
    8020039e:	0141                	addi	sp,sp,16
    802003a0:	8082                	ret

00000000802003a2 <console_putchar>:
		     : "memory");
	return a0;
}

void console_putchar(int c)
{
    802003a2:	1141                	addi	sp,sp,-16
    802003a4:	e422                	sd	s0,8(sp)
    802003a6:	0800                	addi	s0,sp,16
	register uint64 a1 asm("a1") = arg1;
    802003a8:	4581                	li	a1,0
	register uint64 a2 asm("a2") = arg2;
    802003aa:	4601                	li	a2,0
	register uint64 a7 asm("a7") = which;
    802003ac:	4885                	li	a7,1
	asm volatile("ecall"
    802003ae:	00000073          	ecall
	sbi_call(SBI_CONSOLE_PUTCHAR, c, 0, 0);
}
    802003b2:	6422                	ld	s0,8(sp)
    802003b4:	0141                	addi	sp,sp,16
    802003b6:	8082                	ret

00000000802003b8 <console_getchar>:

int console_getchar()
{
    802003b8:	1141                	addi	sp,sp,-16
    802003ba:	e422                	sd	s0,8(sp)
    802003bc:	0800                	addi	s0,sp,16
	register uint64 a0 asm("a0") = arg0;
    802003be:	4501                	li	a0,0
	register uint64 a1 asm("a1") = arg1;
    802003c0:	4581                	li	a1,0
	register uint64 a2 asm("a2") = arg2;
    802003c2:	4601                	li	a2,0
	register uint64 a7 asm("a7") = which;
    802003c4:	4889                	li	a7,2
	asm volatile("ecall"
    802003c6:	00000073          	ecall
	return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
}
    802003ca:	2501                	sext.w	a0,a0
    802003cc:	6422                	ld	s0,8(sp)
    802003ce:	0141                	addi	sp,sp,16
    802003d0:	8082                	ret

00000000802003d2 <shutdown>:

void shutdown()
{
    802003d2:	1141                	addi	sp,sp,-16
    802003d4:	e422                	sd	s0,8(sp)
    802003d6:	0800                	addi	s0,sp,16
	register uint64 a0 asm("a0") = arg0;
    802003d8:	4501                	li	a0,0
	register uint64 a1 asm("a1") = arg1;
    802003da:	4581                	li	a1,0
	register uint64 a2 asm("a2") = arg2;
    802003dc:	4601                	li	a2,0
	register uint64 a7 asm("a7") = which;
    802003de:	48a1                	li	a7,8
	asm volatile("ecall"
    802003e0:	00000073          	ecall
	sbi_call(SBI_SHUTDOWN, 0, 0, 0);
    802003e4:	6422                	ld	s0,8(sp)
    802003e6:	0141                	addi	sp,sp,16
    802003e8:	8082                	ret
	...
