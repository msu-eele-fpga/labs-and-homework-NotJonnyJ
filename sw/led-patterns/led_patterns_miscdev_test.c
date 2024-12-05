#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>

// TODO: update these offsets if your address are different
#define HPS_LED_CONTROL_OFFSET 0x0
#define BASE_PERIOD_OFFSET 0x8
#define LED_REG_OFFSET 0x04


static volatile int running = 1;

void intHandler(int signal) {
	// Turn on hardware-control mode
	FILE *file;
	size_t ret;	
	uint32_t val;

	file = fopen("/dev/led_patterns" , "rb+" );
	if (file == NULL) {
		printf("failed to open file\n");
		exit(1);
	}

	printf("back to hardware-control mode....\n");
	val = 0x00;
    ret = fseek(file, HPS_LED_CONTROL_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	fflush(file);
    printf("\nResetting FPGA back to Hardware Control Mode\n");
    running = 0;
    
    exit(0);
    
}



int main () {

	signal(SIGINT, intHandler);
	FILE *file;
	size_t ret;	
	uint32_t val;

	file = fopen("/dev/led_patterns" , "rb+" );
	if (file == NULL) {
		printf("failed to open file\n");
		exit(1);
	}

	// Test reading the registers sequentially
	printf("\n************************************\n*");
	printf("* read initial register values\n");
	printf("************************************\n\n");

	ret = fread(&val, 4, 1, file);
	printf("HPS_LED_control = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("base period = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("LED_reg = 0x%x\n", val);

	// Reset file position to 0
	ret = fseek(file, 0, SEEK_SET);
	printf("fseek ret = %d\n", ret);
	printf("errno =%s\n", strerror(errno));


	

	printf("\n************************************\n*");
	printf("* LAB 4 Pattern\n");
	printf("************************************\n\n");

	// Turn on software-control mode
	val = 0x01;
	ret = fseek(file, HPS_LED_CONTROL_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	// We need to "flush" so the OS finishes writing to the file before our code continues.
	fflush(file);

	sleep(0.1);

	// Patterns from Lab 4
	while(running == 1){
		val = 0x07;
		ret = fseek(file, LED_REG_OFFSET, SEEK_SET);
		ret = fwrite(&val, 4, 1, file);
		fflush(file);

		sleep(1);

		val = 0x0E;
		ret = fseek(file, LED_REG_OFFSET, SEEK_SET);
		ret = fwrite(&val, 4, 1, file);
		fflush(file);

		sleep(1);

		val = 0x1C;
		ret = fseek(file, LED_REG_OFFSET, SEEK_SET);
		ret = fwrite(&val, 4, 1, file);
		fflush(file);

		sleep(1);

		val = 0x38;
		ret = fseek(file, LED_REG_OFFSET, SEEK_SET);
		ret = fwrite(&val, 4, 1, file);
		fflush(file);

		sleep(1);

		val = 0x70;
		ret = fseek(file, LED_REG_OFFSET, SEEK_SET);
		ret = fwrite(&val, 4, 1, file);
		fflush(file);

		sleep(1);

		val = 0x61;
		ret = fseek(file, LED_REG_OFFSET, SEEK_SET);
		ret = fwrite(&val, 4, 1, file);
		fflush(file);

		sleep(1);

		val = 0x43;
		ret = fseek(file, LED_REG_OFFSET, SEEK_SET);
		ret = fwrite(&val, 4, 1, file);
		fflush(file);

		sleep(1);
	}


	printf("\n************************************\n*");
	printf("* write values\n");
	printf("************************************\n\n");
	// Turn on software-control mode
	val = 0x01;
    ret = fseek(file, HPS_LED_CONTROL_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	// We need to "flush" so the OS finishes writing to the file before our code continues.
	fflush(file);

	val = 0xff;
    ret = fseek(file, LED_REG_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	fflush(file);

	usleep(0.5e6);

	val = 0x00;
    ret = fseek(file, LED_REG_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	fflush(file);

	sleep(1);

	// Turn on hardware-control mode
	printf("back to hardware-control mode....\n");
	val = 0x00;
    ret = fseek(file, HPS_LED_CONTROL_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	fflush(file);

	val = 0x12;
    ret = fseek(file, BASE_PERIOD_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	fflush(file);

	sleep(5);

	// Speed up the base period!
	val = 0x02;
    ret = fseek(file, BASE_PERIOD_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	fflush(file);

	sleep(3);


	printf("\n************************************\n*");
	printf("* read new register values\n");
	printf("************************************\n\n");
	
	// Reset file position to 0
	ret = fseek(file, 0, SEEK_SET);

	ret = fread(&val, 4, 1, file);
	printf("HPS_LED_control = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("base period = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("LED_reg = 0x%x\n", val);

	fclose(file);
	return 0;


	
}
